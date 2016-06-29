##' Create local file with CDISC standards using local copy of standards
##' 
##' @return RRDF model containing CDISC standards stored locally in zip file
##' @param cdisc.files.dir Path to directory with CDISC RDF files
##' @param cdisc.save.zip Path and Filename for zip file with CDISC standards
##' @param cdisc.save.ttl Filename for CDISC turtle file
##' @param remove.cdisc.save.ttl If TRUE then remove the temporary turtle file
##' @param CDISCfilelist A list ofe paths for the rdf.cdisc.org standards files.
##' Default the results of Get.filenames.for.cdisc.standards()
##' 
##' @export Create.cdisc.standards.from.local
Create.cdisc.standards.from.local<- function(
  cdisc.files.dir= "~/projects/phrmwg/rdf.cdisc.org",
  cdisc.save.zip=file.path(system.file("extdata/CDISC-standards-rdf", package="rrdfcdisc"), "cdisc-rdf.zip" ),
  cdisc.save.ttl= file.path(tempdir(),"cdisc-rdf.ttl"),
  remove.cdisc.save.ttl= TRUE,
  CDISCfilelist= Get.filenames.for.cdisc.standards()
  ) {


format.from.ext<- list("ttl"="TURTLE", "rdf"="RDF/XML", "owl"="RDF/XML", "n3"="N3")

cdisc.rdf <- new.rdf(ontology=FALSE)


for (fn in CDISCfilelist) {
  full.fn<- normalizePath(file.path(cdisc.files.dir, fn))
  message("Loading ", full.fn, " .." )
  load.rdf( full.fn,
            format=format.from.ext[[ tools::file_ext(fn) ]],
            appendTo=cdisc.rdf )
  message(".. total number of triples: ", summarize.rdf.noprint(cdisc.rdf) )
  }

message("Final rdf.cdisc.org rrdf store, number of triples: ", summarize.rdf.noprint(cdisc.rdf) )

full.cdisc.save.ttl<- cdisc.save.ttl
cdisc.out <- save.rdf(cdisc.rdf, filename=full.cdisc.save.ttl, format="TURTLE")

if (! file.exists(full.cdisc.save.ttl)) {
    stop("Problem: expected Turtle file not created - ", normalizePath(full.cdisc.save.ttl) )
  }
else {
message("rrdf store saved to turle file: ", normalizePath(full.cdisc.save.ttl) )
}

full.cdisc.save.zip<- path.expand(cdisc.save.zip)
if (file.exists(full.cdisc.save.zip)) {
  file.remove(full.cdisc.save.zip)
  }

message("Writing to zip file ", normalizePath(full.cdisc.save.zip) )
zip( full.cdisc.save.zip, files=c(full.cdisc.save.ttl), extras="-j" )
  if (! file.exists(full.cdisc.save.zip)) {
    stop("Problem: Expected zip file not found - ", normalizePath(full.cdisc.save.zip) )
  }

  if (remove.cdisc.save.ttl) {
    if (file.exists(full.cdisc.save.ttl)) {
      file.remove(full.cdisc.save.ttl)
    }
  }

return(full.cdisc.save.zip)
}

