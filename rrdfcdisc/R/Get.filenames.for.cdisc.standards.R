##' List of files consisting of the rdf.cdisc.org standards
##' 
##' 
##' @return Character vector with filenames for cdisc.rdf.org standards
##' @export Get.filenames.for.cdisc.standards
Get.filenames.for.cdisc.standards<- function(
  ) {

CDISCfilelist<- c(
"resources/w3.org/skos.rdf", 
"resources/dublincore.org/dcam.rdf", 
"resources/dublincore.org/dcelements.rdf", 
"resources/dublincore.org/dcterms.rdf", 
"terminology-2013-06-28/glossary-terminology.owl", 
"terminology-2013-06-28/cdash-terminology.owl", 
"terminology-2013-06-28/sdtm-terminology.owl", 
"terminology-2013-06-28/qs-terminology.owl", 
"terminology-2013-06-28/send-terminology.owl", 
"terminology-2013-06-28/adam-terminology.owl", 
"std/sdtm-1-2.ttl",
"std/all-standards.ttl",
"std/cdash-1-1.ttl",
"std/sdtmig-3-1-3.ttl",
"std/sdtmig-3-1-2.ttl",
"std/adamig-1-0.ttl",
"std/sendig-3-0.ttl",
"std/sdtm-1-3.ttl",
"std/adam-2-1.ttl", 
"schemas/ct-schema.owl", 
"schemas/meta-model-schema.owl", 
"schemas/cdisc-schema.owl"
                  )


return(CDISCfilelist)
}

