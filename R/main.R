library(plumber)

api <- plumb("/home/Predictor.R")
api$run(port=80, host="0.0.0.0")