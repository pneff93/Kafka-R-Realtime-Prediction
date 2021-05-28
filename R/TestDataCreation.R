install.packages("jsonlite")
install.packages("readr")
library(jsonlite)
library(readr)


set.seed(100)

length <- round(rnorm(1000, 88, 5), 3)
height <- round(rnorm(1000, 19, 1), 3)
error <- round(rnorm(1000, 0, 0.1), 3)

weight <- 0.05 * length + 0.01 * height + error

data <- data.frame(length = length, height = height, weight = weight)


result <- apply(data, 1, FUN = function(x){
  return(paste('{"Length": ',x[1],', "Height": ',x[2],'}', 
               sep = ""))
}
)


library("readr")
write(result, file = "fish.txt")
