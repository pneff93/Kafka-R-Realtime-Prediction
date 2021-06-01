import io.kotest.core.spec.style.StringSpec
import io.kotest.extensions.mockserver.MockServerListener
import io.kotest.matchers.shouldBe
import org.mockserver.client.MockServerClient
import org.mockserver.model.HttpRequest
import org.mockserver.model.HttpResponse
import java.util.*


class PredictorTest : StringSpec() {

    private val properties =  Properties()

    init {

        listener(MockServerListener(8000))

        beforeTest {
            MockServerClient("localhost", 8000).`when`(
                HttpRequest.request()
                    .withMethod("GET")
                    .withPath("/prediction")
                    .withQueryStringParameter("length", "1.0")
                    .withQueryStringParameter("height", "1.0")
            ).respond(
                HttpResponse.response()
                    .withBody("10")
            )
        }

        properties.setProperty("Model_URL", "http://localhost:8000/prediction")

        "Predictor works correctly - valid request" {

            val predictor = Predictor(properties)
            val expected = Fish(1.0, 1.0, "now", 10.0)

            val result: Fish = predictor.requestWeight(Fish(1.0, 1.0, "now"))
            result shouldBe expected
        }

        "Predictor works correctly - invalid request" {

            val predictor = Predictor(properties)
            val expected = Fish(0.0, 0.0, "now", null)

            val result: Fish = predictor.requestWeight(Fish(0.0, 0.0, "now"))
            result shouldBe expected
        }
    }
}
