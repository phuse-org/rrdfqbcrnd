##' Get compLabel value from meta data data.frame using compType and compName as keys
##'
##' 
##' @param metaData data.frame with columns compType, compName and compLabel
##' @param compType a vector with values of compType, or NULL if not used
##' @param compName select on the value of compName
##' @param defaultValue if not NULL then a character string providing the default value in 
##' @return the value of the meta data or the the provided default value if keys are not found
##' @export
GetValueFromMetadata<- function(metaData,compType=NULL,compName=NULL,defaultValue=NULL) {

  if (is.null(compType)) {
  RowMetaData<- which(metaData$compName==compName )
  if (length(RowMetaData)>1) {
    stop("More than one row with compName ", compName)
       }
  } else
  {  
  RowMetaData<- which(metaData$compType %in% compType & metaData$compName==compName )
  }
  if (length(RowMetaData)>1) {
    stop("More than one row with compType ", paste(compType, sep=" "), " and compName ", compName )
  }
  if (length(RowMetaData)==0) {
    if (is.null(defaultValue)) {
    stop("No row with compType ", paste(compType, sep=" "), " and compName ", compName )
    }
    return(defaultValue)
  }
  return(as.character(metaData[ RowMetaData, "compLabel" ]))
}

      
  
  
