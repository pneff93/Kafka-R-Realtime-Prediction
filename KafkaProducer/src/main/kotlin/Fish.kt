import java.text.SimpleDateFormat
import java.util.*

data class Fish(
    val Length: Double,
    val Height: Double,
    val Timestamp: String? = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'").format(Date())
)
