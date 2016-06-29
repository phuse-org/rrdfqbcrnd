##' SPARQL query for dimensions in RDF data cube
##'
##' @param forsparqlprefix PREFIX statements for SPARQL query
##' @return SPARQL query
##' @family SPARQL queries
##' @export
GetDimensionsSparqlQuery<- function( forsparqlprefix ) {
dimensions.rq<-   paste(forsparqlprefix,
'
select * where
{ [] qb:dimension ?p .  }
',
"\n"
)
dimensions.rq
}
