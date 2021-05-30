import com.beust.klaxon.Klaxon
import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import kotlinx.coroutines.runBlocking
import org.apache.logging.log4j.kotlin.logger
import java.util.*

class Predictor(private val properties: Properties) {

    private val logger = logger(javaClass.name)

    fun requestWeight(fish: Fish): Fish {

        val payload: String = Klaxon().toJsonString(mapOf("length" to fish.Length, "height" to fish.Height))
        val url: String = properties.getProperty("Model_URL")
        val response: Any? = request(payload, Url(url))

        if(response != null){
            fish.Predicted_Weight = response.toString().toDouble()
        }
        return fish
    }


    private fun request(payload: String, url: Url): Any? =

        runBlocking {

            val client = HttpClient(CIO)

            try {
                val response: HttpResponse = client.request(url) {
                    method = HttpMethod.Get
                    body = payload
                }
                client.close()
                return@runBlocking response.readText()

            } catch (e: Exception){
                logger.error("Could not receive a weight for payload: $payload")
                return@runBlocking null
            }
        }
}
