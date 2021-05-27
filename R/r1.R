

set.seed(100)

length <- round(rnorm(1000, 88, 5), 3)
height <- round(rnorm(1000, 19, 1), 3)
error <- round(rnorm(1000, 0, 0.1), 3)

weight <- 0.05 * length + 0.01 * height + error

data <- data.frame(length = length, height = height, weight = weight)

lm <- lm(weight ~ . , data = data)
summary(lm)
plot(lm)

library(jsonlite)

result <- apply(data, 1, FUN = function(x){
  return(paste('{"Length": ',x[1],', "Height": ',x[2],'}', 
               sep = ""))
}
)


library("readr")
write(result, file = "fish.txt")


set.seed(1000)

length <- round(rnorm(10, 88, 5), 3)
height <- round(rnorm(10, 19, 1), 3)

data2 <- data.frame(length = length, height = height)

precictWeight(length, height, lm)
precictWeight("hello", height, lm)


precictWeight <- function(length, height, lm){
  
  tryCatch(
    {
      prediction <- predict(lm, data.frame(length = length, height = height))
      return(prediction) 
    },
    error = function(cond){
      message("Prediction did not work")
      return(NA)
    }
  )
}
