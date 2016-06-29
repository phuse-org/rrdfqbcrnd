##' Get dsdname for the RDF data cube
##' TODO: change the way domainname is used - should only use the dsdName
##' @param forsparqlprefixcommon string with prefix defintions
##' @param store the RDF store containing the datacube
##' @return the dsdName for the cube
##' @export GetDsdNameFromCube
GetDsdNameFromCube<- function( store, forsparqlprefixcommon=GetForSparqlPrefix() ) {

tempstr<- as.character(sparql.rdf(store, GetDsdNameSparqlQuery( forsparqlprefixcommon )))
if (length(tempstr)>1) {
  warning("Got ", tempstr, " with more than one DSD name in the RDF model",
          "\nWill proceed with the first")
}
tempstrvec<- unlist(strsplit( tempstr[[1]], "/"))
dsdName<- tempstrvec[length(tempstrvec)]

dsdName
}


