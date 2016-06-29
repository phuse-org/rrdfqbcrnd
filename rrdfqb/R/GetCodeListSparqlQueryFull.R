##' SPARQL query for codelists in RDF data cube 
##' 
##' @param forsparqlprefix string with prefix defintions
##' @param dsdName Dataset Descriptor Name, if NULL then return for all dsd in the cube
##' @return SPARQL query
##' @family SPARQL queries
##' @export
## ToDo(mja): Note CodedProperty is not defined in the codelist - maybe we should do that
GetCodeListSparqlQueryFull<- function( forsparqlprefix, dsdName=NULL ) {
codelists.rq<-   paste(forsparqlprefix,
'
select distinct ?DataStructureDefinition ?component ?dimension ?c ?cprefLabel ?cl ?clprefLabel ?vn ?vnd2rq ?vct ?vnop ?vnval
where {
   ?DataStructureDefinition a qb:DataStructureDefinition ;
        qb:component ?component .
   ?component a qb:ComponentSpecification .
   ?component qb:dimension ?dimension .

   ?dimension qb:codeList ?c .
   OPTIONAL { ?c skos:prefLabel ?cprefLabel .   }
   OPTIONAL { ?c rrdfqbcrnd0:DataSetRefD2RQ ?vnd2rq . }
   OPTIONAL { ?c rrdfqbcrnd0:R-columnname ?vn . }
   OPTIONAL { ?c rrdfqbcrnd0:codeType     ?vct .          }

   ?c skos:hasTopConcept ?cl .
   OPTIONAL { ?cl skos:prefLabel ?clprefLabel . }
   OPTIONAL { ?cl rrdfqbcrnd0:R-selectionoperator ?vnop . }
   OPTIONAL { ?cl rrdfqbcrnd0:R-selectionvalue ?vnval .   }
',
ifelse(is.null(dsdName), NULL,
       paste( 'values ( ?DataStructureDefinition ) {',
       paste( "(", "ds:", dsdName, ")", sep="", collapse="\n" ),
       '}',
       sep="\n", collapse="\n")
       ),
'
}
order by ?dimension ?cl ?dimensionrefLabel
'
)
codelists.rq
}
