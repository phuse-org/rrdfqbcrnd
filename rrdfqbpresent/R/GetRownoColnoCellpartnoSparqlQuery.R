##' SPARQL query for dimensions in RDF data cube
##'
##' @param forsparqlprefix PREFIX statements for SPARQL query
##' @return SPARQL query
##' @family SPARQL queries
##' @export
GetRownoColnoCellpartnoSparqlQuery<- function( forsparqlprefix ) {
rownocolnocellpartno.rq<-   paste(forsparqlprefix,
'
select distinct ?rowno ?colno ?cellpartno
where { 
?s a qb:Observation ; 
crnd-attribute:rowno ?rowno ;
crnd-attribute:colno ?colno ;
crnd-attribute:cellpartno ?cellpartno .
}
order by ?rowno ?colno ?cellpartno
',
"\n"
)
rownocolnocellpartno.rq
}
