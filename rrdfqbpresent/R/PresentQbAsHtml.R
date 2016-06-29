##' Create HTML file for RDF data cube given by turtle file
##' 
##' @param dataCubeFile 
##' @param htmlfile 
##' @param rowdim 
##' @param coldim 
##' @param idrow 
##' @param idcol 
##' @return 
##' @examples 
PresentQbAsHtml<- function( dataCubeFile, htmlfile, rowdim, coldim, idrow, idcol ) {
    store <- new.rdf()  # Initialize
    cat("Loading ", dataCubeFile, "\n")
    temp<-load.rdf(dataCubeFile, format="TURTLE", appendTo= store)

    dsdName<- GetDsdNameFromCube( store )
    domainName<- GetDomainNameFromCube( store )
    forsparqlprefix<- GetForSparqlPrefix( domainName )

    dimensions<- sparql.rdf(store, GetDimensionsSparqlQuery( forsparqlprefix ) )
    attributesDf<- sparql.rdf(store, GetAttributesSparqlQuery( forsparqlprefix ))

    outhtmlfile<- MakeHTMLfromQb( store, forsparqlprefix, dsdName, domainName,
                                 dimensions, rowdim, coldim, idrow, idcol,
                                 htmlfile, useRDFa=TRUE, compactDimColumns=FALSE,
                                 debug=FALSE)

    outhtmlfile
}
