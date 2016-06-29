##' Get empty data.frame with column corresponding to the metadata data.frame
##'
##' 
##' @return empty data.frame with column corresponding to the metadata data.frame
##' @export

GetEmptyMetadata<-  function() {
df<- data.frame(
  compType=character(),
  compName=character(),
  codeType=character(),
  nciDomainValue=character(),
  compLabel=character(),
  Comment=character(),       
  stringsAsFactors=FALSE  )
}
