##' Load CDISC standards
##'
##' 
##' @return RRDF model containing CDISC standards stored locally in
##' zip file
##' @param cdisc.load.zip Path and filename to zip file with turtle
##' version of rdf.cdisc.org. Default location is in package
##' extdata/CDISC-standards-rdf directory files cdisc-rdf.zip
##' @param cdisc.load.ttl Path and filename for the unzipped turtle
##' version of rdf.cdisc.org. Default location is file cdisc-rdf.ttl
##' in R session temporary directory
##' @param remove.cdisc.load.ttl If TRUE then the remove the unzipped
##' turtle version of rdf.cdisc.org
##' @examples
##' cubestore<- Load.cdisc.standards()
##'  
##' @export Load.cdisc.standards
Load.cdisc.standards<- function(
  cdisc.load.zip= file.path(
    system.file( "extdata/CDISC-standards-rdf", package="rrdfcdisc" ), "cdisc-rdf.zip"
    ),
  cdisc.load.ttl= file.path(tempdir(),"cdisc-rdf.ttl"),
  remove.cdisc.load.ttl= TRUE  
  ) {

  cdisc.rdf<- new.rdf()

  message("Start loading rdf.cdisc.org contents from ", cdisc.load.zip )
  if (! file.exists(cdisc.load.zip)) {
    stop("Expected file not found - ", cdisc.load.zip )
  }
  unzip( cdisc.load.zip, files=basename(cdisc.load.ttl), exdir=dirname(cdisc.load.ttl) )
  if (! file.exists(cdisc.load.ttl)) {
    stop("Expected file not found - ", cdisc.load.ttl )
  }
  load.rdf(cdisc.load.ttl, format="TURTLE", appendTo=cdisc.rdf )

  message("Done loading rdf.cdisc.org contents, number of triples: ", summarize.rdf.noprint(cdisc.rdf) )
  if (remove.cdisc.load.ttl) {
    if (file.exists(cdisc.load.ttl)) {
      file.remove(cdisc.load.ttl)
    }
  }
  return(cdisc.rdf)

}
