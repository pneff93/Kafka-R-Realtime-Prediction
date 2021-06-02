import kotlinx.coroutines.runBlocking

fun main() {

    val measurementProducer = FishMeasurementProducer()
    val weightProducer = FishWeightProducer()
    val properties = ProducerProperties()

    val measurement = FishMeasurement::class.java.getResource("/measurement.txt").readText().split("\n")
    val weight = FishWeight::class.java.getResource("/weight.txt").readText().split("\n")

    runBlocking {

        while (true) {

            val threadMeasurement = measurementProducer.produceEvents(properties, measurement)
            threadMeasurement.join()
            val threadWeight = weightProducer.produceEvents(properties, weight)
            threadWeight.join()
        }
    }
}