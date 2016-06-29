##' SPARQL query for dimensions and attributes from RDF data cube in workbook format
##' @param forsparqlprefix PREFIX part of SPARQL query
##' @param domainName domainName for the RRDF cube
##' @param dimensions dimensions
##' @param attributes attributes 
##' @return SPARQL query
##' 
##' @export
GetObservationsWithDescriptionSparqlQuery<- function( forsparqlprefix, domainName, dimensions, attributes ) {
  cube.observations.rq<-  paste(
    forsparqlprefix,
    "select * where {",
    "\n",
    "?s a qb:Observation  ;", "\n",
## TODO: better way of using label    
##    "rdfs:label        ?olabel;", "\n",
    paste("qb:dataSet",  paste0( "ds:", "dataset", "-", domainName), " ;", sep=" ", collapse="\n"), "\n",
    paste0( dimensions, " ", sub("crnd-dimension:", "?", dimensions), ";", collapse="\n"),
    "\n",
    paste0( attributes, " ", sub("crnd-attribute:", "?", attributes), ";", collapse="\n"),
    "\n",                          
    "crnd-measure:measure      ?measure .      \n",
    paste0( "optional{ ", sub("crnd-dimension:", "?", dimensions), " ",
           "skos:prefLabel",
           " ",
           sub("crnd-dimension:", "?", dimensions), "value" ,
           " . ", "}",
           collapse="\n"),
    "\n",                              
    paste0( "optional{ ", dimensions, " ",
           "rdfs:label",
           " ",
           sub("crnd-dimension:", "?", dimensions), "label" ,
           " . ", "}",
           collapse="\n"),
    "\n",                              
    paste0( "BIND( IRI(", dimensions, ")",
           " as",
           " ",
           sub("crnd-dimension:", "?", dimensions), "IRI" ,
           ")",
           collapse="\n"),
    "\n",                          
    "BIND( IRI( ?s ) AS ?measureIRI)",                              
    "\n",
    "} ",
## TODO(mja) Make more clever way of sorting    
##    "ORDER BY ?olabel",
    "\n"
    )
  cube.observations.rq
}
