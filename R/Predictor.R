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
