## predict the weight
#' @post /weightprediction
#' @get /weightprediction

precictWeight <- function(length, height, lm){
  
  require(jsonlite)
  
  body <- jsonlite::fromJSON(req$postBody)
  
  .data <- body$.data
  .trans <- body$.trans
  .key <- body$.key
  .value <- body$.value
  .select <- body$.select
  
  
  
  tryCatch(
    {
      prediction <- predict(lm, data.frame(length = length, height = height))
      return(prediction) 
    },
    error = function(cond){
      message("Prediction did not work")
      return(NA)
    }
  )
}



#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}


install.packages("plumber")
library(plumber)
# 'plumber.R' is the location of the file shown above
pr("plumber.R") %>%
  pr_run(port=8000)