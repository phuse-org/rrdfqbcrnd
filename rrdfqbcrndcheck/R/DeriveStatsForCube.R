##' Derive the descriptive statistics defined in a cube
##' 
##' @param store a RRDF store containing one or more date cubes
##' @param forsparqlprefix prefixes for SPARQL queries
##' @param domainName domainName for the RRDF cube
##' @param dataSet data.frame containing dataset to validate against/derive measures
##' @param deriveMeasureList TODO(mja): add code for this variabel
##' @param validation.measure list with property, prefix and
##' URIprefix. The derived results is stored in the cube in the store
##' using the property. This is only used if checkOnly==TRUE
##' @param dsdName Dataset Descriptor Name
##' @param checkOnly TRUE if only the check is performed (default),
##' FALSE then measure is overwritten with the results
##' @param myprefixes Prefixes used for storing the results - TODO(mja): combined with forsparqlprefix
##' @param filterexpr SPARQL filter expression for selecting the observations to return. Default is observations where measure in the qube differs from the caculated results. If blank (" "), then the all observations are returned, including the results derived from the cube. THis is usefull to get the results without having any measures defined.
##' @return list with status TRUE if the operation was sucessfull
##' @export

DeriveStatsForCube<- function(store, forsparqlprefix, domainName, dsdName, dataSet, deriveMeasureList=NULL, checkOnly=TRUE, validation.measure=NULL, myprefixes=NULL, filterexpr=NULL, verbose=FALSE ) {

    if (!is.data.frame(dataSet)) {
        message("Changing dataSet to data.frame")
        dataSet<- as.data.frame(dataSet)
    }
    
    if (is.null(validation.measure)  ) {
        validation.measure<- NULL
        validation.measure$property<- "qbderiv:result"
        validation.measure$prefix<- unlist(strsplit(validation.measure$property,":"))[1]
        validation.measure$namespace<- paste0("http://www.example.org/dc/",tolower(domainName),"/validmeas/")
    }

    codelists.rq<- GetCodeListSparqlQuery( forsparqlprefix, dsdName )
    ##  cat(codelists.rq,"\n")
    cube.codelists<- as.data.frame(sparql.rdf(store, codelists.rq), stringsAsFactors=FALSE)
    ##  str(cube.codelists)

    ##  print(cube.codelists$clprefLabel)
    codelist.all<- cube.codelists[ cube.codelists$clprefLabel=="_ALL_",]
    subsetting.dimensions<- list();

    ## TODO(mja): the variable name/column name in the data frame should be part of the datacube.
    ## This would remove the need for the workaround below using gsub
    for (i in 1:nrow(codelist.all))
    {
        codeName<- gsub("[^:]*:","", codelist.all[i,"dimension"])
        if (! (codeName %in% c("factor", "procedure")) ) {
            ## TODO(mja): when denominator also becomes a dimension, then include in list
            ##        cat("codeName: ", codeName, "\n" )
            subsetting.dimensions[[codeName]] <-
                                                as.character(codelist.all[i,"cl"])
        }
    }

    dimensionsRq <- GetDimensionsSparqlQuery( forsparqlprefix )
    dimensions<- sparql.rdf(store, dimensionsRq)

    attributesRq<- GetAttributesSparqlQuery( forsparqlprefix )
    attributes<- sparql.rdf(store, attributesRq)

    observationsRq<- GetObservationsSparqlQuery( forsparqlprefix, domainName, dimensions, attributes )
    observations<- as.data.frame(sparql.rdf(store, observationsRq ), stringsAsFactors=FALSE)

    ## print(head(observations))
    ## str(observations)


    ## TODO cts:cdiscSubmissionValue could also be used instead of skos:prefLabel
    ## TODO by code:saffl-Y does not have cts:cdiscSubmissionValue

    ## TODO: this should be defined in a RDF model
    ## using list for key-value lookup to function for descriptive statistic
    proc<-GetDescrStatProcedure()
    
    if (nrow(observations )<1) {
        stop("no rows in observations")
    }

    
    if (verbose) {
        cat("Subsetting dimensions: ", paste0(names(subsetting.dimensions), collapse=", "),"\n")
    }
    
    results<- new.rdf(ontology=FALSE)
    Ndiff<-0
    
    for (r in  1:nrow(observations )  ) {
        if (verbose) {
            cat("Cube observation sequence number ", r, ".\n" )
        }
        thisobs<-  observations[r,]
        if (verbose) {
            cat("Derive results for URI ", as.character(thisobs["s"]),
                "procedure ", as.character(thisobs["procedure"]),
                "factor", as.character(thisobs["factor"]), sep=", ", fill=TRUE)
        }

        data.subset.logical<- rep(TRUE, nrow(dataSet))
        logicalExpr<- NULL
        for (v in names(subsetting.dimensions)) {
            if ( thisobs[v ] != subsetting.dimensions[[ v ]] ) {
                if (as.character(thisobs[ paste0(v,"value") ]) == "_NONMISS_") {
                    logicalExpr<- c( logicalExpr, paste0(toupper(v), "!=", "NA") )
                    data.subset.logical<- data.subset.logical & ( !is.na(dataSet[,toupper(v)]) ) 
                } else {
                    logicalExpr<- c( logicalExpr,
                                    paste0(toupper(v), "==", as.character(thisobs[ paste0(v,"value") ])))
                    data.subset.logical<- data.subset.logical &
                        ( dataSet[,toupper(v)] == as.character(thisobs[ paste0(v,"value") ]) )
                }
            }
        }

        if (verbose) {
            cat("Data subsetting expression ", paste0(logicalExpr,collapse=" & "), ".\n",
                "Data set row contributing ", sum(data.subset.logical), "\n")
        }
        
        has.calculated.result<- FALSE
        result<- NULL

        if (thisobs["procedure"] %in% names(proc) ) {
            forthis<- proc[[ as.character(thisobs["procedure" ]) ]]
            if (forthis$univfunc=="univfunc1")  {
                AOD<- as.vector(dataSet[data.subset.logical, toupper(as.character(thisobs["factorvalue"]))])
                if (verbose) {
                    print(AOD)
                }
                result<- (forthis$fun)(AOD)
                has.calculated.result<- TRUE
                ##   print(paste("AOD number of observations", nrow(AOD)))
            } else if (forthis$univfunc=="univfunc2") {
                ## Here the result must be a vector
                ## TODO(mja): USUBJID should not be hardcoded, but change to be a parameter 
                AOD<- dataSet$USUBJID[data.subset.logical]
                if (verbose) {
                    print(data.subset.logical)
                    print(AOD)
                }
                result<- (forthis$fun)(AOD)
                has.calculated.result<- TRUE
            } else if (forthis$univfunc=="univfunc3" & thisobs["factor"]== "code:factor-proportion") {
                
                denom.def<- tolower(thisobs["denominator"])
                denom.data.subset.logical<- rep(TRUE, nrow(dataSet))
                for (v in setdiff(names(subsetting.dimensions),denom.def) ) {
                    if ( thisobs[v ] != subsetting.dimensions[[ v ]] ) {
                        subset.for.var<-dataSet[,toupper(v)] == as.character(thisobs[ paste0(v,"value") ])
                        denom.data.subset.logical<- denom.data.subset.logical & subset.for.var
                    }
                }

                AOD<- dataSet$USUBJID[data.subset.logical]
                denom.data<- dataSet$USUBJID[denom.data.subset.logical]     
                result<- length(AOD) / length( denom.data ) * 100;
                has.calculated.result<- TRUE
            }
        }
        else {
            stop("Handling of ", thisobs["procedure"], " is not defined")
        }

        if (has.calculated.result) {
            if (verbose) {
                cat("   ", paste("result", result," in cube observation ", thisobs["s"]," value ", thisobs["measure"], sep=" "), "\n" )
            }
            if (is.null(result) | is.na(result) | result != thisobs["measure"]) {
                message(paste("difference in cube observation ", thisobs["s"],
                              " expected ", thisobs["measure"],
                              " got ", as.character(result),
                              " relative ", (
                                  if (as.numeric(thisobs["measure"])==0) NA else
                                  (format( (result-as.numeric(thisobs["measure"]))/as.numeric(thisobs["measure"]),digits=6 ))
                              ), 
                              "for ", as.character(thisobs["factorvalue"]),
                        " statistic ", as.character(thisobs["procedure"]),
                        sep=" "), "\n" )
            Ndiff<- Ndiff+1
        }
        if (! checkOnly ) {
            subj<- gsub("ds:", myprefixes$prefixDS, thisobs["s"])
            pred<- gsub(paste0(validation.measure$prefix,":"),validation.measure$namespace,validation.measure$property)
            ##      cat( "-->  ", subj, "\n")
            ##      cat( "-->  ", pred, "\n")
            ##      cat( "-->  ", paste(result), "\n")
            add.data.triple( results,
                            subject=subj, 
                            predicate=pred,
                            data=paste(result), type="double")
        }
    }
    else {
        Ndiff<- Ndiff+1
        message(thisobs["s"], ifelse(has.calculated.result, result, "No result determined") )
        if (verbose) {
            print( paste( thisobs["s"], ifelse(has.calculated.result, result, "No result determined") ) )
        }
    }
    
    
} # for

if (verbose) {
    cat("Number of differences ", Ndiff, "\n")
}    
if (! checkOnly) {  
    prval<- paste0("prefix ", validation.measure$prefix,": ","<", validation.measure$namespace, ">\n")

    ## print(prval)
    cube.measure.result.rq<-
        paste(forsparqlprefix, prval,
              "select * where {",
              "    ?s a qb:Observation  ;",
              paste0("       qb:dataSet", " ", paste0( "ds:", "dataset", "-", domainName), " ;", sep=" ", collapse=" "),
              "       crnd-dimension:procedure      ?procedure ;      ",
              "       crnd-measure:measure      ?measure ;      ",
              "    .",
              paste0("      optional{ ?s ", validation.measure$property, " ?result }      "),
              "} order by ?s",
              "\n",
              sep="\n"
              )

    if (verbose) {
        cat(cube.measure.result.rq, "\n" )
    }
    cube.measure.result<-  sparql.rdf(combine.rdf(store,results), cube.measure.result.rq);
    
    ## print(cube.measure.result)

    if (is.null(filterexpr)) {
        filterexpr<- " filter ( (xsd:float(?measure)-xsd:float(?result)) != 0 || !bound(?result) ) "
                                        #  filterexpr<- " "
    }
    
    cube.check.rq<-  
        paste(forsparqlprefix, prval,
              "select ?s ?procedure ?measure ?result ((xsd:float(?measure)-xsd:float(?result)) as ?diff) where {",
              "    ?s a qb:Observation  ;",
              paste0("       qb:dataSet", " ", paste0( "ds:", "dataset", "-", domainName), " ;", sep=" ", collapse=" "),
              "       crnd-dimension:procedure      ?procedure ;      ",
              "       crnd-measure:measure      ?measure ;      ",
              "    .",
              paste0("      optional{ ?s ", validation.measure$property, " ?result }      "),
              filterexpr,
              "} order by ?s",
              "\n",
              sep="\n"
              )

    cube.check<- sparql.rdf(combine.rdf(store,results), cube.check.rq );
    
    if (verbose) {
        print("If the result is <0 x 0> matrix then all value matches")
    }
    return(cube.check)
} else {
    return(Ndiff==0)
}
}
