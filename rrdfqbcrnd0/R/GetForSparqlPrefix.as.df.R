##' Get the dataframe with prefix
##'
##' 
##' @param domainName Domain Name for the RDF data cube, none if NULL
##' @param common.prefixes Common prefixes, using default if NULL
##' @param custom.prefixes Custom prefixes, using default if NULL
##' @return Character string with PREFIX statements delimited by CR
##' @export GetForSparqlPrefix.as.df

GetForSparqlPrefix.as.df<- function( domainName=NULL, common.prefixes=NULL, custom.prefixes=NULL  ) {

if (is.null(common.prefixes)) { 
  common.prefixes <- GetCommonPrefixDf()
}

if (is.null(custom.prefixes)) {
  if (is.null(domainName)) {
    custom.prefixes<- NULL
  } else {
## TODO: ensure that is meaningfull to use tolower(domainName)
    custom.prefixes <-Get.qb.crnd.prefixes(tolower(domainName))
  }
}

rbind(common.prefixes, custom.prefixes)
}
