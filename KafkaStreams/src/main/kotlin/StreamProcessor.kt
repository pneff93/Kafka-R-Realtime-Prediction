import org.apache.kafka.common.serialization.Serdes
import org.apache.kafka.streams.KafkaStreams
import org.apache.kafka.streams.StreamsBuilder
import org.apache.kafka.streams.Topology
import org.apache.kafka.streams.kstream.Consumed
import org.apache.kafka.streams.kstream.Produced
import org.apache.logging.log4j.kotlin.logger

class StreamProcessor(properties: StreamProperties, private val predictor: Predictor) {

    val streams = KafkaStreams(createTopology(), properties.configureProperties())

    private val logger = logger(javaClass.name)

    private fun createTopology(): Topology {

        val processor = StreamsBuilder()

        processor
            .stream(
                "machine-measurement",
                Consumed.with(Serdes.String(), FishSerde())
            )
            .filter { _, value -> value != null }
            .mapValues { value -> predictor.requestWeight(value) }
            .peek { key, value -> logger.info("Weight predicted for key: $key and value: $value") }
            .to(
                "weight-prediction",
                Produced.with(Serdes.String(), FishSerde())
            )

        return processor.build()
    }
}