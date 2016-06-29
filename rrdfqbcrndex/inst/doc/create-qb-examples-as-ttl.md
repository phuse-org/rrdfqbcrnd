Create turtle version of example files
======================================

This script creates the result and codelist for a simple DEMO table.

``` r
library(rrdfancillary)
library(rrdfcdisc)
library(rrdfqb)
library(rrdfqbcrnd0)
devtools::load_all(pkg="../..")
```

    ## Loading rrdfqbcrndex

All files are stored in the directory

``` r
targetDir<- system.file("extdata/sample-rdf", package="rrdfqbcrndex")
(targetDir)
```

    ## [1] "/home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf"

RDF data cubes specified in workbook
------------------------------------

First, get the workbook.

``` r
RDFCubeWorkbook<- system.file("extdata/sample-cfg", "RDFCubeWorkbook.xlsx", package="rrdfqbcrndex")
(RDFCubeWorkbook)
```

    ## [1] "/home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-cfg/RDFCubeWorkbook.xlsx"

Create the DM sample cube.

``` r
dm.cube.fn<- BuildCubeFromWorkbook(RDFCubeWorkbook, "DM" )
```

    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!

``` r
cat("DM cube stored as ", dm.cube.fn, "\n")
```

    ## DM cube stored as  /tmp/RtmpuIQtha/DC-DM-R-V-0-5-2.ttl

``` r
targetFile<- file.path(targetDir,"DC-DM-sample.ttl")

if (file.copy( dm.cube.fn, targetFile, overwrite=TRUE)) {
  cat("DM cube copied to ", normalizePath(targetFile), "\n")
}
```

    ## DM cube copied to  /home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf/DC-DM-sample.ttl

Create the AE sample cube.

``` r
ae.cube.fn<- BuildCubeFromWorkbook(RDFCubeWorkbook, "AE" )
```

    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!

``` r
cat("AE cube stored as ", ae.cube.fn, "\n")
```

    ## AE cube stored as  /tmp/RtmpuIQtha/DC-AE-R-V-0-5-2.ttl

``` r
targetFile<- file.path(targetDir,"DC-AE-sample.ttl")
if (file.copy( ae.cube.fn, targetFile, overwrite=TRUE)) {
  cat("AE cube copied to ", normalizePath(targetFile), "\n")
}
```

    ## AE cube copied to  /home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf/DC-AE-sample.ttl

RDF data cube in csv files
--------------------------

``` r
demoObsDataCsvFn<- system.file("extdata/sample-cfg", "demo.AR.csv", package="rrdfqbcrndex")
demoObsData <- read.csv(demoObsDataCsvFn,stringsAsFactors=FALSE)

##TODO add measurefmt; quick hack - affects vignettes/cube-from-workbook.Rmd and
##TODO inst/data-raw/create-qb-examples-as-ttl.Rmd
if (!( "measurefmt" %in% names(demoObsData))) {
demoObsData$measurefmt<- "%6.1f"
demoObsData$measurefmt[ demoObsData$procedure %in% c("n", "nmiss", "count") ]<- "%6.0f"
## sprintf( demoObsData$measurefmt, demoObsData$measure)
}

demoMetaDataCsvFn<- system.file("extdata/sample-cfg", "DEMO-Components.csv", package="rrdfqbcrndex")
demoMetaData <- read.csv(demoMetaDataCsvFn,stringsAsFactors=FALSE)

demo.cube.fn<- BuildCubeFromDataFrames(demoMetaData, demoObsData )
```

    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!

``` r
cat("DEMO cube stored as ", normalizePath(demo.cube.fn), "\n")
```

    ## DEMO cube stored as  /tmp/RtmpuIQtha/DC-DEMO-R-V-0-5-2.ttl

``` r
targetFile<- file.path(targetDir,"DC-DEMO-sample.ttl")

if (file.copy( demo.cube.fn, targetFile, overwrite=TRUE)) {
   cat("DEMO cube copied to ", normalizePath(targetFile), "\n")
 }
```

    ## DEMO cube copied to  /home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf/DC-DEMO-sample.ttl
