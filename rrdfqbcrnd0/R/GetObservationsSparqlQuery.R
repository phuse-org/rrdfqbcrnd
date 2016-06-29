##' SPARQL query for observations from RDF data cube in workbook format
##' @param forsparqlprefix PREFIX part of SPARQL query
##' @param domainName domainName for the RRDF cube
##' @param dimensions dimensions, vector or r x 1 matrix
##' @param attributes attributes, vector or r x 1 matrix
##' @return SPARQL query
##' @export
GetObservationsSparqlQuery<- function( forsparqlprefix, domainName, dimensions, attributes ) {
cube.observations.rq<-  paste( forsparqlprefix,
    "select * where {",
    "?s a qb:Observation  ;", 
    paste0( "    ", "qb:dataSet",  " ", "ds:", "dataset", "-", domainName, " ;", collapse="\n"),
    paste0( "    ", dimensions, " ", sub("crnd-dimension:", "?", dimensions ), ";", collapse="\n"),
    paste0( "    ", attributes, " ", sub("crnd-attribute:", "?", attributes ), ";", collapse="\n"),
    "    crnd-measure:measure ?measure .      ",
    paste0( "optional{ ", sub("crnd-dimension:", "?", dimensions), " ",
           "skos:prefLabel",
           " ",
           sub("crnd-dimension:", "?", dimensions ), "value" ,
           " . ", "}", collapse="\n" 
           ),
    "} ",
    "order by ?s",
    "\n",
    sep="\n", collapse="\n"
   )
cube.observations.rq
}

