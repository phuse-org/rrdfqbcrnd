##' SPARQL query for dimensions, attributes and measure from RDF data cube in workbook format
##'
##' @inheritParams GetObservationsSparqlQuery
##' @return SPARQL query
##' @export
GetDimAttrMeasInWorkbookFormatSparqlQuery<- function( forsparqlprefix ) {
cube.observations.rq<-  paste( forsparqlprefix,
'
select ?compType ?compName ?codeType ?nciDomainValue
where {
{[] qb:dimension ?compName.
 optional {  ?compName qb:codeList ?codeList . ?codeList mms:inValueDomain ?nciDomainValue }
 values (?compType) { ("dimension") }  }
union
{ ?compName a qb:AttributeProperty . values (?compType) { ("attribute") } }
union
{ ?compName a qb:MeasureProperty . values (?compType) { ("measure") } }
}
',
  "\n"
   )
cube.observations.rq
}
