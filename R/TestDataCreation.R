install.packages("jsonlite")
install.packages("readr")
library(jsonlite)
library(readr)


# Salmon first shift
set.seed(101)

length <- round(rnorm(200, 88, 5), 3)
height <- round(rnorm(200, 19, 1), 3)
error <- round(rnorm(200, 0, 0.1), 3)
weight <- 0.05 * length + 0.01 * height + error

data1 <- data.frame(species = "salmon", id = seq(1, 200), length = length, height = height, weight = weight)


# Walleye second shift
set.seed(102)

length <- round(rnorm(100, 81, 8), 3)
height <- round(rnorm(100, 17, 2), 3)
error <- round(rnorm(100, 0, 0.1), 3)
weight <- 0.02 * length + 0.04 * height + error

data2 <- data.frame(species = "walleye", id = seq(201, 400), length = length, height = height, weight = weight)


# Salmon third shift
set.seed(103)

length <- round(rnorm(200, 88, 5), 3)
height <- round(rnorm(200, 19, 1), 3)
error <- round(rnorm(200, 0, 0.1), 3)
weight <- 0.05 * length + 0.01 * height + error

data3 <- data.frame(species = "salmon", id = seq(401, 600), length = length, height = height, weight = weight)


# Walleye fourth shift
set.seed(104)

length <- round(rnorm(100, 81, 8), 3)
height <- round(rnorm(100, 17, 2), 3)
error <- round(rnorm(100, 0, 0.1), 3)
weight <- 0.02 * length + 0.04 * height + error

data4 <- data.frame(species = "walleye", id = seq(601, 800), length = length, height = height, weight = weight)

# All test data
data <- rbind(data1, data2, data3, data4)
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
