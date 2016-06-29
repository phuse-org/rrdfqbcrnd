##' SPARQL query giving observations for a subset of observatition from RDF data cube
##' @param forsparqlprefix PREFIX part of SPARQL query
##' @param domainName domainName for the RRDF cube
##' @param dimensions dimensions
##' @return SPARQL query
##' @family SPARQL queries
##' @export
##
##
## Testing
## rq<- GetDimsubsetDescSparqlQuery(forsparqlprefix, domainName, rowdim)
## cat(rq)
## sparql.rdf(checkCube, rq)
GetDimsubsetDescSparqlQuery<- function( forsparqlprefix, domainName, dimensions ) {
  varnames<- sub("crnd-dimension:", "?", dimensions)
  ## XX redo code with vectors for each type of variable, varnamesIRI etc
  cube.observations.rq<-  paste(
    forsparqlprefix,
    "select distinct ?prop ?variable  ?label ?codeval ?value ",
    "\n",
## "?propIRI
    " where {",
    "?s a qb:Observation  ;",
    "\n",
    paste("       qb:dataSet",  paste0( "ds:", "dataset", "-", domainName), " ;", sep=" ", collapse="\n"), "\n",
    "?prop ?codeval .", "\n",
    "optional{ ?codeval skos:prefLabel ?value . }",
    "\n",
    "optional{ ?prop rdfs:label ?label . }", 
##     "BIND( IRI( ?prop ) as ?propIRI ) ",
    "\n",
    "values (?variable ?prop) {",
    "\n",
    paste0( "( ", paste0('"',sub("crnd-dimension:", "", dimensions),'"' ), " ", dimensions, " )", collapse="\n" ),
    "}",
    "\n",
    "} ",
    "\n",
    "order by ?prop ?variable  ?label ?codeval ?value ",
    "\n",
    collapse="\n"
   )
cube.observations.rq
}


