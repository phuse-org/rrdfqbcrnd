##' Create prefix definition for SPARQL query from a prefix list
##'
##' The function defines the domain specifif prefixes used for the rdf
##' data cube for the Clinical Research and Development Analysis
##' Results Data
##' 
##' @param prefixlist List of prefixes made by qb.def.prefixlist
##' @return String containing prefix statements for SPARQL query
##' @export Get.rq.prefixlist.df
Get.rq.prefixlist.df<- function( prefixlist ) {

forsparqlprefix<- paste0(paste(
  "prefix",
  paste(tolower(gsub("^prefix", "", names(prefixlist))),":",sep=""),
  paste("<",prefixlist,">",sep=""),
  sep=" ",collapse="\n"),"\n")

forsparqlprefix
}
  
