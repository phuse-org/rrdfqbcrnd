##' SPARQL query for DataStructureDefinition in RDF data cube
##'
##' @param forsparqlprefixcommon string with prefix defintions
##' @param dsdName Dataset Descriptor Name
##' @return SPARQL query
##' @family SPARQL queries
##' @export
GetDsdNameSparqlQuery<- function( forsparqlprefixcommon=GetForSparqlPrefix() ) {
dsd.rq<-   paste(forsparqlprefixcommon,
'
select ?dsd
where {
?dsd a qb:DataStructureDefinition 
} 
'
)
dsd.rq
}
