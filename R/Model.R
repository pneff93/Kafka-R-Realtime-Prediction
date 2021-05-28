
load("/home/trainingData.RData")

lm <- lm(weight ~ . , data = data)

save(data = lm, file = "model.RData")
