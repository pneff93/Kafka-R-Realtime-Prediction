## predict the weight

#' @param length
#' @param height
#' @serializer unboxedJSON
#' @get /prediction
predictWeight <- function(length, height){
  
  tryCatch(
    {
      length <- as.numeric(length)
      height <- as.numeric(height)
      
      load("/home/model.RData")
      
      prediction <- predict(lm, data.frame(length = length, height = height))
      return(list(Weight = prediction, ModelTime = lm$time))
    },
    error = function(cond){
      
      message("Prediction did not work")
      return(NA)
    }
  )
}



## retrain model

#' @post /train
train <- function(){
  library(mongolite)
  library(dplyr)
  
  tryCatch({
    connection <- mongo(collection = "TrainingData",
                        db = "Weight",
                        url = "mongodb://user:password@mongo:27017")
    
    dataAggr <- connection$aggregate('[
                {"$sort": {"_id": -1}},
                {"$limit": 50}
                                   ]')
  
    data <- dataAggr %>% select(length = Length, height = Height, weight = ActualWeight)
  
    lm <- lm(weight ~ length + height , data = data)
    lm$time <- Sys.time()
  
    save(data = lm, file = "/home/model.RData")
    message("New model saved")
  },
  error = function(cond){
    message ("Retraining did not work")
    }
  )
}

