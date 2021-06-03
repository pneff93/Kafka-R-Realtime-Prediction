install.packages("jsonlite")
install.packages("readr")
library(jsonlite)
library(readr)


# Salmon first shift: 3 min
set.seed(101)

length <- round(rnorm(90, 88, 5), 3)
height <- round(rnorm(90, 19, 1), 3)
error <- round(rnorm(90, 0, 0.1), 3)
weight <- 0.05 * length + 0.01 * height + error

data1 <- data.frame(species = "salmon", id = seq(1, 90), length = length, height = height, weight = weight)


# Walleye second shift : 4 min
set.seed(102)

length <- round(rnorm(120, 81, 8), 3)
height <- round(rnorm(120, 17, 2), 3)
error <- round(rnorm(120, 0, 0.1), 3)
weight <- 0.02 * length + 0.04 * height + error

data2 <- data.frame(species = "walleye", id = seq(91, 210), length = length, height = height, weight = weight)


# Salmon third shift : 4 min
set.seed(103)

length <- round(rnorm(120, 88, 5), 3)
height <- round(rnorm(120, 19, 1), 3)
error <- round(rnorm(120, 0, 0.1), 3)
weight <- 0.05 * length + 0.01 * height + error

data3 <- data.frame(species = "salmon", id = seq(211, 330), length = length, height = height, weight = weight)



# All test data
data <- rbind(data1, data2, data3)
data$id <- as.character(data$id)


# Measurement
measurement <- apply(data, 1, FUN = function(x){
  return(paste('{"Species": "',x[1], '", "Fish_Id": "',x[2], '", "Length": ',x[3],', "Height": ',x[4],'}', 
               sep = ""))
}
)
library("readr")
write(measurement, file = "measurement.txt")


# Weight 
weight <- apply(data, 1, FUN = function(x){
  return(paste('{"Species": "',x[1], '", "Fish_Id": "',x[2], '", "Weight": ',x[5],'}', 
               sep = ""))
}
)
library("readr")
write(weight, file = "weight.txt")
