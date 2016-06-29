##' SPARQL query for attributes in RDF data cube
##'
##' 
##' @param forsparqlprefix string with prefix defintions
##' @return SPARQL query
##' @family SPARQL queries
##' @export
GetAttributesSparqlQuery<- function( forsparqlprefix ) {
attributes.rq<-   paste(forsparqlprefix,
'
select * where
{ ?p a qb:AttributeProperty .  }
',
"\n"
)
attributes.rq
}
