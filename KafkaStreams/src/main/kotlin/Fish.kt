data class Fish(
    val Length: Double,
    val Height: Double,
    val Timestamp: String,
    var Prediction: Prediction? = null
)

data class Prediction(
    val weight: Double,
    val modelTime: String
)
