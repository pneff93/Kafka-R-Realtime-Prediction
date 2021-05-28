set.seed(200)

length <- round(rnorm(1000, 88, 5), 3)
height <- round(rnorm(1000, 19, 1), 3)
error <- round(rnorm(1000, 0, 0.1), 3)

weight <- 0.05 * length + 0.01 * height + error

data <- data.frame(length = length, height = height, weight = weight)

save(data = data, file = "trainingData.RData")
