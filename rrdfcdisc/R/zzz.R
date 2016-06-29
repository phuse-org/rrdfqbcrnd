##' @noRd
##

env <- new.env(parent=emptyenv()) 

#  Following http://stackoverflow.com/questions/12598242/global-variables-in-packages-in-r

.onLoad <- function(libname, pkgname) {
  env[["cdiscstandards"]]<- NULL

  env[["qbCDISCprefixes"]]<-  list(
 "rdf"= "http://www.w3.org/1999/02/22-rdf-syntax-ns#" ,
 "skos"="http://www.w3.org/2004/02/skos/core#" ,
 "prov"="http://www.w3.org/ns/prov#" ,
 "rdfs"="http://www.w3.org/2000/01/rdf-schema#" ,
 "dcat"="http://www.w3.org/ns/dcat#" ,
 "owl"= "http://www.w3.org/2002/07/owl#" ,
 "xsd"= "http://www.w3.org/2001/XMLSchema#" ,
 "pav"= "http://purl.org/pav" ,
 "dc" = "http://purl.org/dc/elements/1.1/",
 "dct"= "http://purl.org/dc/terms/" ,
 "mms"= "http://rdf.cdisc.org/mms#" ,
 "cts"= "http://rdf.cdisc.org/ct/schema#" ,
 "cdiscs"= "http://rdf.cdisc.org/std/schema#", 
 "cdash-1-1"= "http://rdf.cdisc.org/std/cdash-1-1#", 
 "cdashct"= "http://rdf.cdisc.org/cdash-terminology#", 
 "sdtmct"= "http://rdf.cdisc.org/sdtm-terminology#", 
 "sdtm-1-2"= "http://rdf.cdisc.org/std/sdtm-1-2#", 
 "sdtm-1-3"= "http://rdf.cdisc.org/std/sdtm-1-3#", 
 "sdtms-1-3"= "http://rdf.cdisc.org/sdtm-1-3/schema#", 
 "sdtmig-3-1-2"= "http://rdf.cdisc.org/std/sdtmig-3-1-2#", 
 "sdtmig-3-1-3"= "http://rdf.cdisc.org/std/sdtmig-3-1-3#", 
 "sendct"= "http://rdf.cdisc.org/send-terminology#", 
 "sendig-3-0"= "http://rdf.cdisc.org/std/sendig-3-0#", 
 "adamct"= "http://rdf.cdisc.org/adam-terminology#", 
 "adam-2-1"= "http://rdf.cdisc.org/std/adam-2-1#", 
 "adamig-1-0"= "http://rdf.cdisc.org/std/adamig-1-0#", 
 "adamvr-1-2"= "http://rdf.cdisc.org/std/adamvr-1-2#"
)  
    
  invisible()
}

