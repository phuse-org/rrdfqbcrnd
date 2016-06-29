##' SPARQL query for codelists in RDF data cube
##'
##' @param forsparqlprefix string with prefix defintions
##' @param dsdName Dataset Descriptor Name
##' @return SPARQL query
##' @family SPARQL queries
##' @export
GetComponentSparqlQuery<- function( forsparqlprefix, dsdName ) {
codelists.rq<-   paste(forsparqlprefix,
'
select distinct ?p ?label
where {
?DataStructureDefinition a qb:DataStructureDefinition ;
   qb:component ?component .
?component a qb:ComponentSpecification .
?component qb:dimension ?p .
?component rdfs:label ?label
values ( ?DataStructureDefinition ) {
',
paste0( "(", "ds:", dsdName, ")"),
'
}
}
order by ?p ?cl ?prefLabel
'
)
codelists.rq
}
