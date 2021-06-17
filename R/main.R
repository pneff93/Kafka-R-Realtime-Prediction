library(plumber)

api <- plumb("/home/Predictor.R")
api$run(port=8000, host="0.0.0.0")