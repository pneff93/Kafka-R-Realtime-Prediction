import java.text.SimpleDateFormat
import java.util.*

data class Fish(
    val species: String,
    val length_1: Double,
    val length_2: Double,
    val length_3: Double,
    val height: Double,
    val width: Double,
    val timestamp: String? = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'").format(Date())
)
