data class Fish(
    val Fish_Id: String,
    val Species: String,
    val Length: Double,
    val Height: Double,
    val Timestamp: String,
    var Prediction: Prediction? = null
)

data class Prediction(
    val Weight: Double,
    val ModelTime: String
)
