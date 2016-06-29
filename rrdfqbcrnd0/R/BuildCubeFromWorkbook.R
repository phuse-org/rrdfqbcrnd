##' Build a RDF data cube based on specification given in a spreadsheet 
##'
##' 
##' @param RDFCubeWorkbook Filename and path to an workbook specifying the datacube
##' @param domainName The domainName create the data cube using the corresponding tab in the workbook
##' @param endpoint Used for determined codelist for dimensions. When
##' codetype="SDTM" to give the URL for the remote endpoint. If NULL
##' then the local rdf.cdisc.store from the environment is used.
##' @return The filename for the generated turtle file
##' @export
BuildCubeFromWorkbook<- function(RDFCubeWorkbook,domainName,endpoint=NULL) {
  
# Prefixe sources: 1. Workbook sheet CubePrefixes 2. custom built on domain name
# Prefixes common to all cubes (regardless of domain) 
common.prefixes <- read.xlsx(RDFCubeWorkbook,sheetName=paste0("CubePrefixes"),stringsAsFactors=FALSE)

###############################################################################
# Read the skeleton  specifications to dataframe
# Source workbook: compType, compName, compLabel
# TODO: Replace some use of compLabel with a var : compNameClass, formed by
#       Upcase of first letter of the compName value.

cubeMetadata <- xlsx::read.xlsx(RDFCubeWorkbook,sheetName=paste0(domainName,"-Components"),stringsAsFactors=FALSE)

metadataSource <-cubeMetadata[grep("metadata", cubeMetadata$compType),]

if (any(metadataSource$compName=="obsFileNameDirectory")) {
obsFileDir<- as.character(metadataSource[ metadataSource$compName=="obsFileNameDirectory", "compLabel" ])
} else  {obsFileDir<-""}

if (nchar(obsFileDir)==0 | obsFileDir=="!example" ) {
obsFileDir<- dirname(RDFCubeWorkbook)
}

obsFile<- as.character(metadataSource[ metadataSource$compName=="obsFileName", "compLabel" ])
obsFileName<- file.path(obsFileDir,obsFile)
if (! file.exists(obsFileName) ) {
  # consider using try instead
  stop( paste0("Expected file ", obsFileName, " does not exist" ))
  }

obsData <- read.csv(obsFileName,stringsAsFactors=FALSE)

outcube<- BuildCubeFromDataFrames(cubeMetadata, obsData, common.prefixes, endpoint=endpoint)
}
