##' SPARQL query for dimensions and attributes in RDF data cube
##'
##' 
##' @param forsparqlprefix string with prefix defintions
##' @return SPARQL query
##' @family SPARQL queries
##' @export
GetDimAttrSparqlQuery<- function( forsparqlprefix ) {
dimAttr.rq<-   paste(forsparqlprefix,
'
select * where
{ {[] qb:dimension ?p . } union {  ?p a qb:AttributeProperty . } }"
',
"\n"
)
dimAttr.rq
}
