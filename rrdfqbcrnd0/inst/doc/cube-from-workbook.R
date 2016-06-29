## ---- eval=TRUE----------------------------------------------------------
library(rrdfqbcrnd0)

## ---- eval=TRUE----------------------------------------------------------
RDFCubeWorkbook<- system.file("extdata/sample-cfg", "RDFCubeWorkbook.xlsx", package="rrdfqbcrnd0")

## ---- eval=TRUE----------------------------------------------------------
cubeMetadata <- read.xlsx(RDFCubeWorkbook,
                          sheetName=paste0("DM-Components"),
                          stringsAsFactors=FALSE)
knitr::kable(
  cubeMetadata[ cubeMetadata$compType %in% c("dimension", "attribute", "measure"),
               c("codeType", "compName","nciDomainValue", "compLabel")]
  )
knitr::kable(cubeMetadata[ cubeMetadata$compType=="metadata",c("compName","compLabel")])

## ---- eval=TRUE----------------------------------------------------------
dm.cube.fn<- BuildCubeFromWorkbook(RDFCubeWorkbook, "DM" )
cat("DM cube stored as ", normalizePath(dm.cube.fn), "\n")

ae.cube.fn<- BuildCubeFromWorkbook(RDFCubeWorkbook, "AE" )
cat("AE cube stored as ", normalizePath(ae.cube.fn), "\n")

## ---- eval=TRUE----------------------------------------------------------
demoObsDataCsvFn<- system.file("extdata/sample-cfg", "demo.AR.csv", package="rrdfqbcrnd0")
demoObsData <- read.csv(demoObsDataCsvFn,stringsAsFactors=FALSE)

##TODO add measurefmt; quick hack - affects vignettes/cube-from-workbook.Rmd and
##TODO inst/data-raw/create-qb-examples-as-ttl.Rmd
if (!( "measurefmt" %in% names(demoObsData))) {
demoObsData$measurefmt<- "%6.1f"
demoObsData$measurefmt[ demoObsData$procedure %in% c("n", "nmiss", "count") ]<- "%6.0f"
## sprintf( demoObsData$measurefmt, demoObsData$measure)
}

demoMetaDataCsvFn<- system.file("extdata/sample-cfg", "DEMO-Components.csv", package="rrdfqbcrnd0")
demoMetaData <- read.csv(demoMetaDataCsvFn,stringsAsFactors=FALSE)


demo.cube.fn<- BuildCubeFromDataFrames(demoMetaData, demoObsData )
cat("DEMO cube stored as ", normalizePath(demo.cube.fn), "\n")

## ---- echo=TRUE, results='asis'------------------------------------------
dataCubeFile<- demo.cube.fn
# dataCubeFile<- ae.cube.fn
# dataCubeFile<- dm.cube.fn

## ---- echo=TRUE----------------------------------------------------------
checkCube <- new.rdf()  # Initialize
load.rdf(dataCubeFile, format="TURTLE", appendTo= checkCube)
summarize.rdf(checkCube)

## ---- echo=TRUE----------------------------------------------------------
dsdName<- GetDsdNameFromCube( checkCube )
domainName<- GetDomainNameFromCube( checkCube )
forsparqlprefix<- GetForSparqlPrefix( domainName )

## ---- echo=TRUE----------------------------------------------------------
observations1Rq<- paste( forsparqlprefix,
'
select *
where {?s ?p ?o .}
limit 10
',
"\n"
)
observations1<- sparql.rdf(checkCube, observations1Rq  )
knitr::kable(head(observations1))

## ---- echo=TRUE----------------------------------------------------------
observations2Rq<-  paste( forsparqlprefix,
'
select *
where { ?s a qb:Observation ; ?p ?o .}
limit 10
',
"\n"                               
)
observations2<- sparql.rdf(checkCube, observations2Rq)
knitr::kable(head(observations2, 10))

## ---- echo=TRUE----------------------------------------------------------
componentsRq<- GetComponentSparqlQuery( forsparqlprefix, dsdName )
components<- as.data.frame(sparql.rdf(checkCube, componentsRq), stringsAsFactors=FALSE)
components$vn<- gsub("crnd-dimension:|crnd-attribute:|crnd-measure:","",components$p)
knitr::kable(components[,c("vn", "label")])

## ---- echo=TRUE----------------------------------------------------------
codelistsRq<- GetCodeListSparqlQuery( forsparqlprefix, dsdName )
codelists<- as.data.frame(sparql.rdf(checkCube, codelistsRq), stringsAsFactors=FALSE)
codelists$vn<- gsub("crnd-dimension:|crnd-attribute:|crnd-measure:","",codelists$p)
codelists$clc<- gsub("code:","",codelists$cl)
knitr::kable(codelists[,c("vn", "clc", "prefLabel")])

## ---- echo=TRUE----------------------------------------------------------
dimensionsRq <- GetDimensionsSparqlQuery( forsparqlprefix )
dimensions<- sparql.rdf(checkCube, dimensionsRq)
knitr::kable(dimensions)

## ---- echo=TRUE----------------------------------------------------------
attributesRq<- GetAttributesSparqlQuery( forsparqlprefix )
attributes<- sparql.rdf(checkCube, attributesRq)
knitr::kable(attributes)

## ---- echo=TRUE----------------------------------------------------------
observationsRq<- GetObservationsSparqlQuery( forsparqlprefix, domainName, dimensions, attributes )
cat(observationsRq)
observations<- as.data.frame(sparql.rdf(checkCube, observationsRq ), stringsAsFactors=FALSE)
knitr::kable(observations[ 1:10 ,
   c(paste0(sub("crnd-dimension:|crnd-attribute:|crnd-measure:", "", dimensions), "value"),sub("crnd-dimension:|crnd-attribute:|crnd-measure:", "", attributes), "measure")])


## ---- echo=TRUE----------------------------------------------------------
observationsDescriptionRq<- GetObservationsWithDescriptionSparqlQuery( forsparqlprefix, domainName, dimensions, attributes )
cat(observationsDescriptionRq)
observationsDesc<- as.data.frame(sparql.rdf(checkCube, observationsDescriptionRq ), stringsAsFactors=FALSE)
knitr::kable(observationsDesc[ 1:10 ,
     c(paste0(rep(sub("crnd-dimension:|crnd-attribute:|crnd-measure:", "", dimensions),each=3),
       c("label", "value", "IRI")),
       sub("crnd-dimension:|crnd-attribute:|crnd-measure:", "", attributes), "measure", "measureIRI"
       )]
       )


## ---- echo=TRUE----------------------------------------------------------
GetFormularFromCube( checkCube, forsparqlprefix )

## ---- echo=TRUE----------------------------------------------------------
workbookDimAttrMeasRq<- GetDimAttrMeasInWorkbookFormatSparqlQuery( forsparqlprefix ) 
dimensionsattr<- sparql.rdf(checkCube, workbookDimAttrMeasRq )
knitr::kable(dimensionsattr)

## ---- echo=TRUE----------------------------------------------------------
workbookMetadataRq<- GetMetaDataInWorkbookFormatSparqlQuery( forsparqlprefix )
metadata<- sparql.rdf(checkCube, workbookMetadataRq)
cubeVersion<- gsub("-",".", gsub("DC-.*-R-V-([^\\.]+).ttl", "\\1", metadata[ metadata[,2]=="distribution", "compLabel"], perl=TRUE))
metadataX<- rbind(metadata, cbind(compType="metadata", compName="cubeVersion", compLabel=cubeVersion))
knitr::kable(metadataX)

## ---- echo=TRUE----------------------------------------------------------
sessionInfo()

