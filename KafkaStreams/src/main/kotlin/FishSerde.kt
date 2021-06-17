import com.beust.klaxon.Klaxon
import org.apache.kafka.common.serialization.Deserializer
import org.apache.kafka.common.serialization.Serde
import org.apache.kafka.common.serialization.Serializer
import org.apache.logging.log4j.kotlin.logger

class FishSerde : Serializer<Fish>, Deserializer<Fish>, Serde<Fish> {

    private val logger = logger(javaClass.name)

    override fun deserialize(topic: String, data: ByteArray): Fish? {
        return try {
            Klaxon().parse<Fish>(data.inputStream())
        } catch (e: Exception) {
            logger.error("$e: Error deserializing message: ${data.toString(Charsets.UTF_8)}")
            null
        }
    }

    override fun serialize(topic: String, data: Fish): ByteArray {
        return Klaxon().toJsonString(data).toByteArray()
    }

    override fun close() {
    }

    override fun configure(configs: MutableMap<String, *>?, isKey: Boolean) {
    }

    override fun serializer(): Serializer<Fish> = this
    override fun deserializer(): Deserializer<Fish> = this
}
