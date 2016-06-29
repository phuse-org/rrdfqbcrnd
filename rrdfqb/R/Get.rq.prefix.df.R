##' Create prefix definition for SPARQL query from 
##'
##' The function defines the domain specifif prefixes used for the rdf
##' data cube for the Clinical Research and Development Analysis
##' Results Data
##' 
##' @param prefix.df prefixes as data.frame with column prefix and namespace
##' @return String containing prefix statements for SPARQL query
##' @export Get.rq.prefix.df
Get.rq.prefix.df<- function( prefix.df ) {

forsparqlprefix<- paste0(paste(
  "prefix",
  paste(prefix.df$prefix,":",sep=""),
  paste("<",prefix.df$namespace,">",sep=""),
  sep=" ",collapse="\n"),"\n")

forsparqlprefix
}
  
