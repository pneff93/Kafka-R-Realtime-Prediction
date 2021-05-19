import kotlinx.coroutines.runBlocking

fun main() {

    val eventsProducer = FishEventsProducer()
    val properties = ProducerProperties()
    val data = Fish::class.java.getResource("/fish.txt").readText().split("\n")

    runBlocking {

        while (true) {

            val thread = eventsProducer.produceEvents(properties, data)
            thread.join()
        }
    }
}