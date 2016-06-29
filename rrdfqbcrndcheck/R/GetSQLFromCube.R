##' Get SQL expression for the summary statistics in RDF data cube
##'
##' 
##' @param store The name for the rrdf store
##' @param dsdName The name of the data frame with data (results)
##' @param srcDsName The name of the data frame with underlying data (source)
##' @return SQL expression with the formulars representing the RDF data cube
##' @export

GetSQLFromCube<- function( store, dsdName=NULL, srcDsName="adsl"  ) {

  if (is.null(dsdName)) {
    dsdName<- GetDsdNameFromCube( store )
  }

  domainName<- GetDomainNameFromCube( store )
  forsparqlprefix<- GetForSparqlPrefix( domainName )

  dimensionsRq <- GetDimensionsSparqlQuery( forsparqlprefix )
  dimensions<- sparql.rdf(store, dimensionsRq)

  attributesRq<- GetAttributesSparqlQuery( forsparqlprefix )
  attributes<- sparql.rdf(store, attributesRq)

  observationsRq<- GetObservationsSparqlQuery( forsparqlprefix, domainName, dimensions, attributes )
  observations<- as.data.frame(sparql.rdf(store, observationsRq ), stringsAsFactors=FALSE)

  xx<- apply( observations, 1, function(x) {
    SQLexpr<- c()
    selectExpr<- c()
    groupbyExpr<- c()
    for (vn in names(x)) {
      if ( x["procedurevalue"] %in% c("percent") & vn==tolower(x["denominator"])) {
        vnx<- paste0( "b.", toupper(vn))
      } else {        
        vnx<- paste0( "a.", toupper(vn))
      }
      if (vn %in% gsub("crnd-dimension:", "", c(dimensions)) & ! (vn %in% c("factor", "procedure")) )  {
        if (x[paste0(vn,"value")] == "_ALL_") {
          selectExpr<- c(selectExpr, paste("'_ALL_' as", toupper(vn), collapse=" "))
        } else if (x[paste0(vn,"value")] == "_NONMISS_") {
          selectExpr<- c(selectExpr, paste("'_ALL_' as", toupper(vn), collapse=" "))
        } else {
          selectExpr<- c(selectExpr, vnx)
          groupbyExpr<- c(groupbyExpr,vnx)
        }
      }
    }
  
             
    ## if (!(x["factorvalue"] %in% c("quantity","proportion"))) {
    ##   SQLexpr<- c(SQLexpr, tolower(x["factorvalue"]))
    ##   }
    
    if ( x["procedurevalue"] %in% c("percent")) {
      derivExpr<- paste0("100*avg","(",
                         "a.", toupper(tolower(x["denominator"])), "=",
                         "b.", toupper(tolower(x["denominator"])),
                         ")")
    } else if ( x["procedurevalue"] %in% c("count", "n")) {
      derivExpr<- paste0("CAST( count","(", "*", ") AS REAL)")
    } else if ( x["procedurevalue"] %in% c("mean")) {
        derivExpr<- paste0("avg","(", toupper(tolower(x["factorvalue"])),")" )
    } else if ( x["procedurevalue"] %in% c("q1")) {
        derivExpr<- paste0("lower_quartile","(", toupper(tolower(x["factorvalue"])),")" )
    } else if ( x["procedurevalue"] %in% c("q3")) {
        derivExpr<- paste0("upper_quartile","(", toupper(tolower(x["factorvalue"])),")" )
    } else if ( x["procedurevalue"] %in% c("min", "max", "std", "median")) {
        derivExpr<- paste0("upper_quartile","(", toupper(tolower(x["factorvalue"])),")" )
    } else  {
      message("Aggregate funtion ", x["procedurevalue"], " can not be handled - no derivation")
##      derivExpr<- paste0(x["procedurevalue"],"(", toupper(tolower(x["factorvalue"])),")" )
        derivExpr<- "Null"
    }

    paste("SELECT",
          paste(
            paste0(selectExpr, collapse=", "),
            paste0("'",x["procedurevalue"],"'"," as procedure"),
            paste0("'",x["factorvalue"],"'"," as factor"), 
            paste0("'",x["denominator"],"'"," as denominator"), 
            paste0("'",x["unit"],"'"," as unit"), 
            paste0( derivExpr, " as measure"), sep=", "
             ),
          "from ", srcDsName, " as a",
          ifelse( x["procedurevalue"] %in% c("percent"),
                 paste0( ", ",
                        "(select distinct ", toupper(tolower(x["denominator"])), " from ", srcDsName, ") as b")
                 , " "
                 ),
          "group by ", paste(groupbyExpr, collapse=", "),
##          "order by ", paste(groupbyExpr, collapse=", "),
          collapse="\n"
          )
  }
             )

  a<-paste0(paste0(unique(xx),collapse="\nUNION\n"),"\n")

#  print(str(observations))
#  print(c(dimensions,attributes))


  qbframe<- observations[,c(paste0(gsub("crnd-dimension:","",dimensions),"value"),gsub("crnd-attribute:","",attributes))]
  names(qbframe)[1:length(dimensions)]<- gsub("crnd-dimension:","",dimensions)


  list(summStatSQL=a,qbframe=qbframe)
}
