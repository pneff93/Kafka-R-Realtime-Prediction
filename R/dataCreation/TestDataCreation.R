install.packages("jsonlite")
install.packages("readr")
library(jsonlite)
library(readr)


# Salmon first shift: 2 min
set.seed(101)

length <- round(rnorm(60, 88, 5), 3)
height <- round(rnorm(60, 19, 1), 3)
error <- round(rnorm(60, 0, 0.1), 3)
weight <- 0.05 * length + 0.01 * height + error

data1 <- data.frame(species = "salmon", id = seq(1, 60), length = length, height = height, weight = weight)


# Walleye second shift : 4 min
set.seed(102)

length <- round(rnorm(60, 81, 8), 3)
height <- round(rnorm(60, 17, 2), 3)
error <- round(rnorm(60, 0, 0.1), 3)
weight <- 0.02 * length + 0.04 * height + error

data2 <- data.frame(species = "walleye", id = seq(61, 120), length = length, height = height, weight = weight)


# Salmon third shift : 4 min
set.seed(103)

length <- round(rnorm(60, 88, 5), 3)
height <- round(rnorm(60, 19, 1), 3)
error <- round(rnorm(60, 0, 0.1), 3)
weight <- 0.05 * length + 0.01 * height + error

data3 <- data.frame(species = "salmon", id = seq(121, 180), length = length, height = height, weight = weight)



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
