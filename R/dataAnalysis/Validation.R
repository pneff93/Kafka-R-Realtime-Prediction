
# species: salmon

set.seed(100)

length <- round(rnorm(100, 88, 5), 3)
height <- round(rnorm(100, 19, 1), 3)
error <- round(rnorm(100, 0, 0.1), 3)

weight <- 0.05 * length + 0.01 * height + error

data <- data.frame(species = "salmon", id = seq(1, 100), length = length, height = height, weight = weight)

load("model.RData")


data$prediction <- predict(lm, data)
data$diff <- abs(data$weight-data$prediction)
data$diffRel <- data$diff / data$weight

summary(data$diffRel)
  # max 7 %, mean 2 %


# new species: walleye

set.seed(101)

length <- round(rnorm(100, 81, 8), 3)
summary(length)

height <- round(rnorm(100, 17, 2), 3)
summary(height)

error <- round(rnorm(100, 0, 0.1), 3)

weight <- 0.02 * length + 0.04 * height + error
summary(weight)


dataWalleye <- data.frame(species = "walleye", id = seq(1, 100), length = length, height = height, weight = weight)
dataWalleye$prediction <- predict(lm, dataWalleye)
dataWalleye$diff <- abs(dataWalleye$weight-dataWalleye$prediction)
dataWalleye$diffRel <- dataWalleye$diff / dataWalleye$weight

summary(dataWalleye$diffRel)
  # min 57 %, mean 82 %

lmWalleye <- lm(weight ~ length + height, data = dataWalleye[1:50, ])
summary(lm2)

dataWalleye$predictionNew <- predict(lmWalleye, dataWalleye)
dataWalleye$diffNew <- abs(dataWalleye$weight-dataWalleye$predictionNew)
dataWalleye$diffRelNew <- dataWalleye$diffNew / dataWalleye$weight

summary(dataWalleye$diffRelNew)
  # max 12 %, mean 3 %



# back again: salmon

data$predictionNew <- predict(lmWalleye, data)
data$diffNew <- abs(data$weight-data$predictionNew)
data$diffRelNew <- data$diffNew / data$weight

summary(data$diffRelNew)
  # min 36 %, mean 44 %