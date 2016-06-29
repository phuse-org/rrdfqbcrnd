##' Get the PREFIX part for a SPARQL for the given domainname
##'
##' 
##' @param domainName Domain Name for the RDF data cube, none if NULL
##' @param common.prefixes Common prefixes, using default if NULL
##' @param custom.prefixes Custom prefixes, using default if NULL
##' @return Character string with PREFIX statements delimited by CR
##' @export
GetForSparqlPrefix<- function( domainName=NULL, common.prefixes=NULL, custom.prefixes=NULL  ) {

    Get.rq.prefix.df(
        GetForSparqlPrefix.as.df(
            domainName=domainName,
            common.prefixes=common.prefixes,
            custom.prefixes=custom.prefixes
            )
        )
}
