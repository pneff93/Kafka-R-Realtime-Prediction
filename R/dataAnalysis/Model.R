
load("trainingData.RData")

lm <- lm(weight ~ length + height , data = data)
lm$time <- Sys.time()

summary(lm)

save(data = lm, file = "model.RData")
