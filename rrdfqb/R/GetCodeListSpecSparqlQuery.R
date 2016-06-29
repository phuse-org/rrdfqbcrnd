##' SPARQL query for which codelists in RDF data cube 
##' 
##' @param forsparqlprefix string with prefix defintions
##' @param dsdName Dataset Descriptor Name, if NULL then return for all dsd in the cube
##' @return SPARQL query
##' @family SPARQL queries
##' @export
## ToDo(mja): Note CodedProperty is not defined in the codelist - maybe we should do that
GetCodeListSpecSparqlQuery<- function( forsparqlprefix, dsdName=NULL ) {
codelists.rq<-   paste(forsparqlprefix,
'
select distinct ?DataStructureDefinition ?component ?dimension ?c ?cprefLabel
where {
   ?DataStructureDefinition a qb:DataStructureDefinition ;
        qb:component ?component .
   ?component a qb:ComponentSpecification .
   ?component qb:dimension ?dimension .

   ?dimension qb:codeList ?c .
   OPTIONAL { ?c skos:prefLabel ?cprefLabel .   }
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
