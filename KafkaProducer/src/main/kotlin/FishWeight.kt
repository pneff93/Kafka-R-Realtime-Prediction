import java.text.SimpleDateFormat
import java.util.*

data class FishWeight(
    val Fish_Id: String,
    val Species: String,
    val Weight: Double,
    val Timestamp: String? = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'").format(Date())
)
