import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import java.util.*

class PredictorIntTest: StringSpec() {

    init {

        "Integration works correctly" {

            // first run docker-compose file in KafkaStreams/src/test/resources

            val properties =  Properties()
            properties.setProperty("Model_URL", "http://localhost:8000/prediction")

            val predictor = Predictor(properties)

            val request = Fish(1.0, 1.0, "now")
            val response = predictor.requestWeight(request)

            response.Length shouldBe request.Length
            response.Height shouldBe request.Height
            response.Timestamp shouldBe request.Timestamp
            response.Predicted_Weight shouldNotBe null
        }
    }
}