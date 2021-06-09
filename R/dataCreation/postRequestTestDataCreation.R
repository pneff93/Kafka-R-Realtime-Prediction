library(mongolite)
library(jsonlite)
connection <- mongo(collection = "TrainingData",
                    db = "Weight",
                    url = "mongodb://user:password@localhost:27017")


data <- connection$find()
data <- data[0:75, ]
write_json(data, path = "postTestData.json")
