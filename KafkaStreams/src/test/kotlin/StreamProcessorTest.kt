import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe
import io.mockk.every
import io.mockk.mockkClass
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.kafka.common.serialization.StringSerializer
import org.apache.kafka.streams.*
import java.util.*

class StreamProcessorTest : StringSpec() {

    private val input = Fish("id", "salmon", 1.0, 1.0, "today", null)
    private val expectedOutput = Fish("id", "salmon", 1.0, 1.0, "today", Prediction(2.0, "yesterday"))

    private val properties = Properties()

    init {

        "Stream Processor works correctly"{

            // Predictor Mock
            val mockPredictor = mockkClass(Predictor::class)
            every { mockPredictor.requestWeight(any()) } returns expectedOutput

            // Properties Mock
            properties.setProperty(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092")
            properties.setProperty(StreamsConfig.APPLICATION_ID_CONFIG, "streamsId")

            val mockProperties = mockkClass(StreamProperties::class)
            every { mockProperties.configureProperties() } returns properties

            // Set up Kafka Streams
            val topology = StreamProcessor(mockProperties, mockPredictor).createTopology()
            val testDriver = TopologyTestDriver(topology, mockProperties.configureProperties())

            // Pipe into topology
            val inputTopic: TestInputTopic<String, Fish> =
                testDriver.createInputTopic("machine-measurement", StringSerializer(), FishSerde())

            inputTopic.pipeInput("testId", input)

            // Consume output topic
            val output: TestOutputTopic<String, Fish> =
                testDriver.createOutputTopic("weight-prediction", StringDeserializer(), FishSerde())

            // Test
            output.readKeyValue() shouldBe KeyValue("testId", expectedOutput)
            testDriver.close()
        }
    }
}