import com.beust.klaxon.Klaxon
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerRecord
import org.apache.logging.log4j.kotlin.logger

class FishEventsProducer {

    private val logger = logger(javaClass.name)

    fun produceEvents(properties: ProducerProperties, data: List<String>): Thread {

        val thread = Thread {
            val klaxon = Klaxon()
            val kafkaProducer = KafkaProducer<String, String>(properties.configureProperties())
            logger.info("Kafka Producer started")

            data.forEach { event ->

                val fish = klaxon.parse<Fish>(event)
                val dataJSON = klaxon.toJsonString(fish)

                kafkaProducer.send(ProducerRecord("machine-measurement", "id", dataJSON))
                logger.info("Event produced with value: $dataJSON")
                Thread.sleep(2000)
            }
        }

        thread.start()
        return thread
    }
}