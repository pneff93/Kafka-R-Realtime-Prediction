import org.gradle.jvm.tasks.Jar

plugins {
    kotlin("jvm") version "1.4.31"
    application
}

application{
    mainClass.set("MainKt")
}

repositories {
    jcenter()
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib-jdk8"))
    implementation("org.apache.kafka:kafka-streams:2.7.0")
    implementation("com.beust:klaxon:5.0.1")
    implementation("org.jetbrains.kotlin:kotlin-reflect:1.4.10")
    implementation("org.apache.logging.log4j:log4j-api-kotlin:1.0.0")
    implementation("org.apache.logging.log4j:log4j-core:2.12.0")
    implementation("org.apache.logging.log4j:log4j-slf4j-impl:2.12.0")
    implementation("io.ktor:ktor-server-netty:1.2.2")
}

val fatJar = task("fatJar", type = Jar::class) {
    baseName = "fatApp"
    manifest {
        attributes["Main-Class"] = application.mainClass
    }
    from(configurations.runtimeClasspath.get().map { if (it.isDirectory) it else zipTree(it) })
    with(tasks.jar.get() as CopySpec)
}
