import org.apache.kafka.common.serialization.Serdes
import org.apache.kafka.streams.KafkaStreams
import org.apache.kafka.streams.StreamsBuilder
import org.apache.kafka.streams.Topology
import org.apache.kafka.streams.kstream.Consumed
import org.apache.kafka.streams.kstream.Produced

class StreamProcessor(private val properties: StreamProperties, private val predictor: Predictor) {

    val streams = KafkaStreams(createTopology(), properties.configureProperties())

    private fun createTopology(): Topology {

        val processor = StreamsBuilder()

        processor
            .stream(
                "machine-data",
                Consumed.with(Serdes.String(), FishSerde())
            )
            .filter { _, value -> value != null }
            .mapValues { value -> predictor.requestWeight(value) }
            .to(
                "weight-prediction",
                Produced.with(Serdes.String(), FishSerde())
            )

        return processor.build()
    }
}