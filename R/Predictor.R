## predict the weight

#' @param length
#' @param height
#' @param species
#' @serializer unboxedJSON
#' @get /prediction
predictWeight <- function(length, height, species){
  
  tryCatch(
    {
      length <- as.numeric(length)
      height <- as.numeric(height)
      species <- as.factor(species)
      
      load("/home/model.RData")
      
      prediction <- predict(lm, data.frame(length = length, height = height, species = species))
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
                {"$sort": {"Timestamp": -1}},
                {"$limit": 50}
                                   ]')
  
    data <- dataAggr %>% select(length = Length, height = Height, weight = ActualWeight, species = Species)
    
    if(length(unique(data$species)) > 1){
    
      data$species <- as.factor(data$species)
      lm <- lm(weight ~ length + height + species, data = data)
      
    } else {
      
      lm <- lm(weight ~ length + height , data = data)
    }
  
    lm$time <- Sys.time()
  
    save(data = lm, file = "/home/model.RData")
    message("New model saved")
  },
  error = function(cond){
    message ("Retraining did not work")
    }
  )
}

