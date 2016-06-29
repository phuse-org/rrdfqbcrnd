##' Get two dimensional table as data.frame from RDF data cube
##'
##' @inheritParams GetDsdNameFromCube
##' @param rowdim vector of dimension and attribute names for row identification
##' @param coldim vector of dimension and attribute names for column identification
##' @param rowlabeldim vector of dimension names to define the row label data.frame
##' @param collabeldim vector of dimension names to define the column label data.frame
##' @param forsparqlprefix PREFIX part of SPARQL query
##' @param domainName domainName for the RRDF cube
##' @return data.frame with result of query, the observations, with
##' attributes for rowLabelDf, colLabelDF, rowlabelURI, collabelURI,
##' obsURI
##'
##' @details The present code uses R to create the two dim representation.
##' This could also be done using a SPARQL query. Most likely this would be a more
##' clear approach.

##' @export GetTwoDimTableFromQb

## TODO: Consider
## rownamefunc function for deriving rownames
## colnamefunc function for columnnames


GetTwoDimTableFromQb<- function( store, forsparqlprefix, domainName, rowdim, coldim, rowlabeldim=NULL, collabeldim=NULL) {
    
    if (is.null(rowlabeldim)) {
        rowlabeldim<- rowdim
    }
    if (is.null(collabeldim)) {
        collabeldim<- coldim
    }

    dimensionsRq <- GetDimensionsSparqlQuery( forsparqlprefix )
    dimensions<- sparql.rdf(store, dimensionsRq)

    attributesRq<- GetAttributesSparqlQuery( forsparqlprefix )
    attributes<- sparql.rdf(store, attributesRq)

    ##  if (! setequal(union(rowdim,coldim),union(dimensions,attributes)) ) {
    ##    stop("union of rowdim and coldim is not the union of dimensions and attributes in the cube")
    ##  }
    if ( length(intersect(rowdim,coldim))>0 ) {
        stop("rowdim and coldim are not disjoint:", intersect(rowdim,coldim))
    }
    observationsDescriptionRq<- GetObservationsWithDescriptionSparqlQuery( forsparqlprefix, domainName, dimensions, attributes )
    ## cat(observationsDescriptionRq)
    observationsDesc<- as.data.frame(sparql.rdf(store, observationsDescriptionRq ), stringsAsFactors=FALSE)
    
    ## ToDo: should also return desciptive labels for the dimensions
    rowdimRq<- GetDimsubsetWithObsSparqlQuery( forsparqlprefix, domainName, rowdim )
    observationsRowDim<- as.data.frame(sparql.rdf(store, rowdimRq ), stringsAsFactors=FALSE)

    ## ToDo: getting the column names (variable) names for the row dimensions
    ## this could be a return parameter from a function like GetDimsubsetWithObsSparqlQuery
    ## to ensure that the naming convention was systematic

    ## ToDo: need a function to determine variable (column names) from
    ## properties for each language (R, SAS etc)

    colnamesRowDim<- gsub("crnd-dimension:|crnd-attribute:", "", rowdim)
    uqr<-data.frame(unique(observationsRowDim[,colnamesRowDim]), stringsAsFactors=FALSE)
    colnames(uqr)<- colnamesRowDim
    ## XX assuming irowno is a unused column name
    irownoseq<- 1:nrow(uqr)
    uqr[,"irowno"]<- irownoseq
    observationsRowDimE<-merge(observationsRowDim, uqr, by=colnamesRowDim, all=TRUE)
    ## XX assuming s is the name of the IRI

    ## head(observationsRowDimE[,c("s","irowno")])


    coldimRq<- GetDimsubsetWithObsSparqlQuery( forsparqlprefix, domainName, coldim )
    observationsColDim<- as.data.frame(sparql.rdf(store, coldimRq ), stringsAsFactors=FALSE)
    colnamesColDim<- gsub("crnd-dimension:|crnd-attribute:", "", coldim)
    ## using data.frame to handle the case where the result is a vector
    uqc<-data.frame(unique(observationsColDim[,colnamesColDim]), stringsAsFactors=FALSE)
    colnames(uqc)<- colnamesColDim
    icolnoseq<- 1:nrow(uqc)
    uqc[,"icolno"]<- icolnoseq
    ##  print(uqc)
    ## head(uqc)
    observationsColDimE<-merge(observationsColDim,uqc, by=colnamesColDim, all=TRUE)
    ## head(observationsColDimE[,c("s","icolno")])

    nIRIs<-  c(sub("crnd-dimension:", "", dimensions), paste0(sub("crnd-dimension:", "", dimensions), "IRI"),"measureIRI" )


    prm<- regexec("^prefix +([^:]+): +<(.*)>$", strsplit(forsparqlprefix,"\n")[[1]])
    ll<-regmatches(strsplit(forsparqlprefix,"\n")[[1]],prm)
    res<-data.frame(matrix(unlist(ll),ncol=3,byrow=TRUE),stringsAsFactors=FALSE)

    ## ToDo: should have a function for this

    observationsDesc[, nIRIs]<- apply(observationsDesc[, nIRIs],c(1,2),
                                      function(x) {gsub("^crnd-attribute:",
                                                        as.character(res[res[,2]=="crnd-attribute",3]), x)})
    
    observationsDesc[, nIRIs]<- apply(observationsDesc[, nIRIs],c(1,2),
                                      function(x) {gsub("^crnd-dimension:",
                                                        as.character(res[res[,2]=="crnd-dimension",3]), x)})

    observationsDesc[, nIRIs]<- apply(observationsDesc[, nIRIs],c(1,2),
                                      function(x) {gsub("^crnd-measure:",
                                                        as.character(res[res[,2]=="crnd-measure",3]), x)})

    observationsDesc[, nIRIs]<- apply(observationsDesc[, nIRIs],c(1,2),
                                      function(x) {gsub("^ds:", as.character(res[res[,2]=="ds",3]), x)})

    observationsDesc[, nIRIs]<- apply(observationsDesc[, nIRIs],c(1,2),
                                      function(x) {gsub("^code:", as.character(res[res[,2]=="code",3]),
                                                        x)})
    
    obsRowIcolno<- merge( observationsRowDimE[,c("s","irowno")],
                         observationsColDimE[,c("s","icolno")], by="s", all=TRUE)

    if (any(duplicated(obsRowIcolno[,c("irowno","icolno")]))) {
        stop("Unexpected an observation is not uniquely identified by row and column number")
    }

    if (any(duplicated(obsRowIcolno[,c("irowno","icolno")]))) {
        stop("unexpected duplicates - see program code")
    }

    observationsDescX<- merge( observationsDesc, obsRowIcolno, by="s", all=TRUE)

    tableFrame<- data.frame(irowno=rep(irownoseq, each=length(icolnoseq) ),
                            icolno=rep(icolnoseq, times=length(irownoseq) ),
                            stringsAsFactors=FALSE )

    observationsDescXX<- merge( tableFrame, observationsDescX, by=c("irowno","icolno"), sort=TRUE, all=TRUE)

    ## display observationsDescXX as a table showing row variables when irowno changes
    ## or alternatively when icolno==1
    ## when irowno is 1 and icolno is 1 then write the row and column headers

    presTable<- uqr
    for (icolno in icolnoseq) {
        presTable[,paste0("col", icolno)]<- rep( NA, length(irownoseq))
    }
    for (icolno in icolnoseq) {
        for (irowno in irownoseq) {
# TODO: quick hack - check why mja 08-dec-2015            
            presTable[irowno,paste0("col", icolno)]<-
                (observationsDescXX[observationsDescXX$irowno==irowno & observationsDescXX$icolno==icolno, "measure"])[1]
        }
    }

    attr(presTable, "rowLabelDf")<- data.frame(
            sparql.rdf(store, GetDimsubsetDescSparqlQuery(forsparqlprefix, domainName, rowdim)),
            stringsAsFactors=FALSE )
    
    attr(presTable, "colLabelDf")<- data.frame(
            sparql.rdf(store, GetDimsubsetDescSparqlQuery(forsparqlprefix, domainName, coldim)),
            stringsAsFactors=FALSE )

    obsURI<- observationsDescXX[ , nIRIs ]
    names(obsURI)[1:length(dimensions)]<- paste0(sub("crnd-dimension:", "", dimensions),"valueIRI")

    attr(presTable, "rowlabelURI")<- "to be defined"
    attr(presTable, "collabelURI")<- "to be defined"
    attr(presTable, "obsURI" )<- obsURI
    attr(presTable, "observationsDesc")<- observationsDescXX 
    attr(presTable, "icolnoseq")<- icolnoseq
    attr(presTable, "irownoseq")<- irownoseq
    presTable
}
