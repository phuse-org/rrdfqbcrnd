xs## @knitr DEMOcodelistfull-race.ru 
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>  
prefix skos: <http://www.w3.org/2004/02/skos/core#>  
prefix prov: <http://www.w3.org/ns/prov#>  
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>  
prefix dcat: <http://www.w3.org/ns/dcat#>  
prefix owl: <http://www.w3.org/2002/07/owl#>  
prefix xsd: <http://www.w3.org/2001/XMLSchema#>  
prefix pav: <http://purl.org/pav>  
prefix dc: <http://purl.org/dc/elements/1.1/>  
prefix dct: <http://purl.org/dc/terms/>  
prefix mms: <http://rdf.cdisc.org/mms#>  
prefix cts: <http://rdf.cdisc.org/ct/schema#>  
prefix cdiscs: <http://rdf.cdisc.org/std/schema#>  
prefix cdash-1-1: <http://rdf.cdisc.org/std/cdash-1-1#>  
prefix cdashct: <http://rdf.cdisc.org/cdash-terminology#>  
prefix sdtmct: <http://rdf.cdisc.org/sdtm-terminology#>  
prefix sdtm-1-2: <http://rdf.cdisc.org/std/sdtm-1-2#>  
prefix sdtm-1-3: <http://rdf.cdisc.org/std/sdtm-1-3#>  
prefix sdtms-1-3: <http://rdf.cdisc.org/sdtm-1-3/schema#>  
prefix sdtmig-3-1-2: <http://rdf.cdisc.org/std/sdtmig-3-1-2#>  
prefix sdtmig-3-1-3: <http://rdf.cdisc.org/std/sdtmig-3-1-3#>  
prefix sendct: <http://rdf.cdisc.org/send-terminology#>  
prefix sendig-3-0: <http://rdf.cdisc.org/std/sendig-3-0#>  
prefix adamct: <http://rdf.cdisc.org/adam-terminology#>  
prefix adam-2-1: <http://rdf.cdisc.org/std/adam-2-1#>  
prefix adamig-1-0: <http://rdf.cdisc.org/std/adamig-1-0#>  
prefix adamvr-1-2: <http://rdf.cdisc.org/std/adamvr-1-2#>  
prefix qb: <http://purl.org/linked-data/cube#>  
prefix rrdfqbcrnd0: <http://www.example.org/rrdfqbcrnd0/>  
prefix code: <http://www.example.org/dc/code/>  
prefix dccs: <http://www.example.org/dc/demo/dccs/>  
prefix ds: <http://www.example.org/dc/demo/ds/>  
prefix crnd-dimension: <http://www.example.org/dc/dimension#>  
prefix crnd-attribute: <http://www.example.org/dc/attribute#>  
prefix crnd-measure: <http://www.example.org/dc/measure#>  
   
INSERT { 
   ?dimension qb:codeList ?c .  
   ?c skos:prefLabel ?cprefLabel .   
}
WHERE { 
  select * where {
 values ( ?dimension ?c ?cprefLabel  ) {  
( crnd-dimension:race  code:race  "Codelist scheme: race"                           )
 }   
  }
}  
;
INSERT { 
   ?c skos:hasTopConcept ?cl .  
  ?cl skos:prefLabel ?clprefLabel .
}
WHERE { 
  select * where {
 values ( ?c ?cl ?clprefLabel ) {  

( code:race  code:race-ASIAN                                     "ASIAN"                                  )
( code:race  code:race-AMERICAN_INDIAN_OR_ALASKA_NATIVE          "AMERICAN INDIAN OR ALASKA NATIVE"       )
( code:race  code:race-BLACK_OR_AFRICAN_AMERICAN                 "BLACK OR AFRICAN AMERICAN"              )
( code:race  code:race-NATIVE_HAWAIIAN_OR_OTHER_PACIFIC_ISLANDER "NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER"  )
( code:race  code:race-WHITE                                     "WHITE"                                  )
( code:race  code:race-_ALL_                                     "_ALL_"                                  )
( code:race  code:race-_NONMISS_                                 "_NONMISS_"                              )

 }   
  }
}  
