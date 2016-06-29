##' SPARQL query for CDISC codelists
##' The query uses the prefixes mms: and cts:.
##' @param forsparqlprefix SPARQL prefix
##' @param nciDomainValue NCI domain value as IRI, for example: sdtmct:C66731 assuming sdtmct: is defined as prefix
##' @return SPARQL query
##' @export
##ToDo(mja): In SPARQL statement consider using ; instead of repeating ?nciDomain.
GetCDISCCodeListSparqlQuery<- function( forsparqlprefix, nciDomainValue ) {
codelists.rq<-   paste(forsparqlprefix,
'select ?nciDomain ?cdiscDefinition ?code ?cdiscSynonym ?nciCode ?nciPreferredTerm ?nciDomainValue
where {
  ?nciDomain mms:inValueDomain        ?nciDomainValue .
  ?nciDomain cts:cdiscDefinition      ?cdiscDefinition .
  ?nciDomain cts:cdiscSubmissionValue ?code .
  ?nciDomain cts:nciCode              ?nciCode .
  ?nciDomain cts:nciPreferredTerm     ?nciPreferredTerm
  OPTIONAL { ?nciDomain cts:cdiscSynonym        ?cdiscSynonym . }
values (?nciDomainValue) {
',
paste0("(", nciDomainValue, ")",collapse="\n"),
'
  }
}
'
)
codelists.rq
}
