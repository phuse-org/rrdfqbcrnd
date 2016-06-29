##' SPARQL query for metadata from RDF data cube in workbook format
##'
##' @inheritParams GetObservationsSparqlQuery
##' @return SPARQL query
##' @export
GetMetaDataInWorkbookFormatSparqlQuery<- function( forsparqlprefix ) {
cube.observations.rq<-  paste( forsparqlprefix,
'
# could show ?dataset
select  ?compType ?compName ?compLabel
where {
{
?dataset a qb:DataSet .
?dataset ?p ?compLabel .
 values (?p ?compName) {
   (dct:title "title" )
   (dcat:distribution "distribution")
   (rdfs:comment "comment" )
   (rdfs:label "label" )
   (dct:description "description" )
   (prov:wasDerivedFrom "obsFileName")
 }
 values (?compType) { ("metadata") }
}
}
',
"\n"
   )
cube.observations.rq
}
