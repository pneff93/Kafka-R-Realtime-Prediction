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

        val url: String = properties.getProperty("Model_URL")

        val response: Any? = request(fish, Url(url))
        val prediction = Klaxon().parse<Prediction>(response.toString())

        if (prediction != null) {
            logger.info("Prediction: ${prediction.Weight} successful with model: ${prediction.ModelTime} and parameters length: ${fish.Length}, height ${fish.Height} and species ${fish.Species}")
            fish.Prediction = prediction
        }
        return fish
    }


    private fun request(fish: Fish, url: Url): Any? =

        runBlocking {

            val client = HttpClient(CIO)

            try {
                val response: HttpResponse = client.request(url) {
                    method = HttpMethod.Get
                    parameter("length", fish.Length)
                    parameter("height", fish.Height)
                    parameter("species", fish.Species)
                }
                client.close()
                return@runBlocking response.readText()

            } catch (e: Exception) {
                logger.error("Could not receive a weight for payload: $fish to url: $url")
                return@runBlocking null
            }
        }
}
