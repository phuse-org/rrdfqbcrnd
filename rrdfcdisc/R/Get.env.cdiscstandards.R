##' Get rdf.cdisc.org rrdf model from local file and store in environment
##'
##' 
##' @return rdf.cdisc.org rrdf model
##' @export Get.env.cdiscstandards

Get.env.cdiscstandards<- function() {
if (is.null(env[["cdiscstandards"]]) ) {
  env[["cdiscstandards"]]<- Load.cdisc.standards()
}
return(TRUE)
}
