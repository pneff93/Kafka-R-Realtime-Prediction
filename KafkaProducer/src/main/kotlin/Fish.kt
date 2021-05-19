import java.text.SimpleDateFormat
import java.util.*

data class Fish(
    val Species: String,
    val Length1: Double,
    val Length2: Double,
    val Length3: Double,
    val Height: Double,
    val Width: Double,
    val timestamp: String? = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'").format(Date())
)
