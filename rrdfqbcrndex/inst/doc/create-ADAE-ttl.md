Create turtle version of ADAE dataset
=====================================

Setup
-----

``` r
library(rrdfancillary)
devtools::load_all(pkg="../..")
```

    ## Loading rrdfqbcrndex

This script creates a turtle version of the ADAE dataset.

The script uses SQLite to export the ADAE dataset, and d2rq (<http://d2rq.org/>) to create a turle version of the file. In the code below it is assumed that d2rq is installed in the directory `/opt/d2rq-0.8.1`.

``` r
library(foreign)
fnadae<- system.file("extdata/sample-xpt", "adae.xpt", package="rrdfqbcrndex")
adae<-read.xport(fnadae)
```

The present code uses `read.xport` to input the sas dataset. TODO: Date variables are note handled correctly. Other methods are available allowing access to more of the meta data in the datasets.

Next step is to dump the data as a SQL dump, that will serve as input to D2RQ. For dumping the data `sqlite` is used as it is the easies to setup. The R-package `RSQLite` (<http://cran.r-project.org/web/packages/RSQLite/RSQLite.pdf>) provides access to `sqlite`.

``` r
## install.packages("RSQLite")
```

The SQL dump is created by transfering the R data.frame to SQLite, and the invoking sqlite to create a dump.

``` r
library(RSQLite)
## create a SQLite instance and create one connection.
m <- dbDriver("SQLite")
## initialize a new database to a tempfile and copy some data.frame
## from the base package into it
tfile <- tempfile()
con <- dbConnect(m, dbname = tfile)
dbWriteTable(con, "adae", adae)
```

    ## [1] TRUE

``` r
dbDisconnect(con)
```

    ## [1] TRUE

``` r
cat("SQLite database stored as ", tfile, "\n")
```

    ## SQLite database stored as  /tmp/RtmpNbPO1j/file6a67421809d7

``` r
dumpFn<- tempfile()
system(paste("sqlite3", tfile, ".dump >", dumpFn, sep=" "))
cat("SQLite database dump in ", dumpFn, "\n")
```

    ## SQLite database dump in  /tmp/RtmpNbPO1j/file6a67755a231d

Next step is to process the dump, so the SQL can be used as input to d2rq. The changes applied are: \* change TEXT to VARCHAR(1000) \* remove top 2 lines with PRAGMA \* in insert statements replace "adae" with adae \* after "AOCC01FL" TEXT add a comma (",") and a new line with PRIMARY KEY (USUBJID,AESEQ)

This could maybe be simplified using RSQlite on dbSendQuery-methods, see (<https://stat.ethz.ch/pipermail/r-sig-db/2010q1/000813.html>). For d2rq documentation see (<file:///opt/d2rq-0.8.1/doc/dump-rdf.html>).

``` r
dumpAfterSedFn <- tempfile()
sedCmd<- paste("sed",
               "-e 's/TEXT/VARCHAR(1000)/g; s/\"AOCC01FL\" VARCHAR(1000)/\"AOCC01FL\" VARCHAR(1000), PRIMARY KEY (USUBJID,AESEQ)/; s/\"adae\"/adae/g; 1,2 d; $ d; ' ",
               dumpFn, ">", dumpAfterSedFn, sep=" ")
system(sedCmd)
cat("SQLite database dump modified stored as ", dumpAfterSedFn, "\n")
```

    ## SQLite database dump modified stored as  /tmp/RtmpNbPO1j/file6a675be22e1b

``` r
## Check only expected changes were applied
## not run due to large output
## system(paste("diff", dumpFn, dumpAfterSedFn, sep=" "))


adaemapttlFn<- file.path(tempdir(), "adae-map.ttl")
adaettlFn<- file.path(tempdir(), "adae.ttl")

d2rqbaseURL<- "http://www.example.org/datasets/"

## -b option does not work with -l
## /opt/d2rq-0.8.1/generate-mapping reports Unknown argument: -b
system(paste("/opt/d2rq-0.8.1/generate-mapping",
             " -l ", dumpAfterSedFn,
             " -o ", adaemapttlFn
             ))

system(paste("/opt/d2rq-0.8.1/dump-rdf",
             " -b ", d2rqbaseURL,
             " -o ", adaettlFn,
             " -l ", dumpAfterSedFn,
             " ", adaemapttlFn
             ))
 


targetDir<- system.file("extdata/sample-rdf", package="rrdfqbcrndex")
if (file.copy(adaemapttlFn, targetDir, overwrite = TRUE)) {
cat( "File ", adaemapttlFn, " copied to directory ", targetDir, "\n")
}
```

    ## File  /tmp/RtmpNbPO1j/adae-map.ttl  copied to directory  /home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf

``` r
if (file.copy(adaettlFn, targetDir, overwrite = TRUE)) {
cat( "File ", adaettlFn, " copied to directory ", targetDir, "\n")
}
```

    ## File  /tmp/RtmpNbPO1j/adae.ttl  copied to directory  /home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf

``` r
### This could maybe also work ..
## m <- dbDriver("SQLite")
## tfile <- tempfile()
## con <- dbConnect(m, dbname = tfile)
## s <- sprintf("create table %s(%s, primary key(%s))", "adae",
##      paste(names(adae), collapse = ", "),
##      paste(names(adae)[c(1,2)],collapse=", ")
##              )
## dbGetQuery(con, s)

## dbWriteTable(con, "adae", adae,append=TRUE)
## dbDisconnect(con)
## tfile
```

### Read in the file

This section demostrates how to access the data for the ADAE dataset.

First the data are loaded into a RDF model.

``` r
dataFilemap<- system.file("extdata/sample-rdf", "adae-map.ttl", package="rrdfqbcrndex")
dataFilemap
```

    ## [1] "/home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf/adae-map.ttl"

``` r
dataFile<- system.file("extdata/sample-rdf", "adae.ttl", package="rrdfqbcrndex")
dataFile
```

    ## [1] "/home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-rdf/adae.ttl"

``` r
store <- new.rdf()  # Initialize
invisible(load.rdf(dataFilemap, format="TURTLE", appendTo= store))
invisible(load.rdf(dataFile, format="TURTLE", appendTo= store))
summarize.rdf(store)
```

    ## [1] "Number of triples: 61002"

Next step is to make a query showing the mappings

``` r
mapping.rq<-"
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
prefix xsd: <http://www.w3.org/2001/XMLSchema#> 
prefix d2rq: <http://www.wiwiss.fu-berlin.de/suhl/bizer/D2RQ/0.1#> 
prefix jdbc: <http://d2rq.org/terms/jdbc/> 
select * where {
   ?mapColumn a d2rq:PropertyBridge ;
                d2rq:column ?d2rqcolumn .
   optional{ ?mapColumn d2rq:datatype ?d2rqdatatype  }
}
"

cat(mapping.rq,"\n")
```

    ## 
    ## prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
    ## prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
    ## prefix xsd: <http://www.w3.org/2001/XMLSchema#> 
    ## prefix d2rq: <http://www.wiwiss.fu-berlin.de/suhl/bizer/D2RQ/0.1#> 
    ## prefix jdbc: <http://d2rq.org/terms/jdbc/> 
    ## select * where {
    ##    ?mapColumn a d2rq:PropertyBridge ;
    ##                 d2rq:column ?d2rqcolumn .
    ##    optional{ ?mapColumn d2rq:datatype ?d2rqdatatype  }
    ## }
    ## 

``` r
resmapping<- data.frame(sparql.rdf(store, mapping.rq),stringsAsFactors=FALSE)
str(resmapping)
```

    ## 'data.frame':    55 obs. of  3 variables:
    ##  $ mapColumn   : chr  "file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESHOSP" "file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESOC" "file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_TRTAN" "file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEHLT" ...
    ##  $ d2rqcolumn  : chr  "ADAE.AESHOSP" "ADAE.AESOC" "ADAE.TRTAN" "ADAE.AEHLT" ...
    ##  $ d2rqdatatype: chr  NA NA "xsd:double" NA ...

``` r
knitr::kable(resmapping)
```

| mapColumn                                                                       | d2rqcolumn    | d2rqdatatype |
|:--------------------------------------------------------------------------------|:--------------|:-------------|
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESHOSP>  | ADAE.AESHOSP  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESOC>    | ADAE.AESOC    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_TRTAN>    | ADAE.TRTAN    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEHLT>    | ADAE.AEHLT    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AELLTCD>  | ADAE.AELLTCD  | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCC03FL> | ADAE.AOCC03FL | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_USUBJID>  | ADAE.USUBJID  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEPTCD>   | ADAE.AEPTCD   | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AGEGR1>   | ADAE.AGEGR1   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESCONG>  | ADAE.AESCONG  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESDISAB> | ADAE.AESDISAB | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_TRTSDT>   | ADAE.TRTSDT   | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCC02FL> | ADAE.AOCC02FL | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_TRTA>     | ADAE.TRTA     | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEDECOD>  | ADAE.AEDECOD  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AELLT>    | ADAE.AELLT    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEBODSYS> | ADAE.AEBODSYS | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_TRTEMFL>  | ADAE.TRTEMFL  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEHLGT>   | ADAE.AEHLGT   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESOD>    | ADAE.AESOD    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AENDY>    | ADAE.AENDY    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESOCCD>  | ADAE.AESOCCD  | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEACN>    | ADAE.AEACN    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_SITEID>   | ADAE.SITEID   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESEQ>    | ADAE.AESEQ    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_ASTDY>    | ADAE.ASTDY    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEREL>    | ADAE.AEREL    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCC04FL> | ADAE.AOCC04FL | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_RACE>     | ADAE.RACE     | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCCFL>   | ADAE.AOCCFL   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEHLGTCD> | ADAE.AEHLGTCD | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_CQ01NAM>  | ADAE.CQ01NAM  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_SAFFL>    | ADAE.SAFFL    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEHLTCD>  | ADAE.AEHLTCD  | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AGEGR1N>  | ADAE.AGEGR1N  | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_ASTDT>    | ADAE.ASTDT    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AETERM>   | ADAE.AETERM   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESLIFE>  | ADAE.AESLIFE  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_SEX>      | ADAE.SEX      | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AEOUT>    | ADAE.AEOUT    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_ADURN>    | ADAE.ADURN    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESDTH>   | ADAE.AESDTH   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESEV>    | ADAE.AESEV    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCCPFL>  | ADAE.AOCCPFL  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_TRTEDT>   | ADAE.TRTEDT   | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_ASTDTF>   | ADAE.ASTDTF   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_RACEN>    | ADAE.RACEN    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESCAN>   | ADAE.AESCAN   | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_ADURU>    | ADAE.ADURU    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AESER>    | ADAE.AESER    | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AENDT>    | ADAE.AENDT    | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCC01FL> | ADAE.AOCC01FL | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_STUDYID>  | ADAE.STUDYID  | NA           |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AGE>      | ADAE.AGE      | xsd:double   |
| <file:///home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/data-raw/#ADAE_AOCCSFL>  | ADAE.AOCCSFL  | NA           |

The code below gets the all values in one record

``` r
s<- paste0("<", d2rqbaseURL,c("ADAE/01-701-1023/2.0E0"), ">")

records.rq<-paste("select * ",
           "where { ?s ?p ?o.",
           " values(?s) {",
           paste("(",s,")", collapse="\n"),
           "}",
           "}", sep="\n", collapse="\n" )
cat(records.rq,"\n")
```

    ## select * 
    ## where { ?s ?p ?o.
    ##  values(?s) {
    ## ( <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> )
    ## }
    ## }

``` r
records.res<- data.frame(sparql.rdf(store, records.rq),stringsAsFactors=FALSE)
str(records.res)
```

    ## 'data.frame':    50 obs. of  3 variables:
    ##  $ s: chr  "http://www.example.org/datasets/ADAE/01-701-1023/2.0E0" "http://www.example.org/datasets/ADAE/01-701-1023/2.0E0" "http://www.example.org/datasets/ADAE/01-701-1023/2.0E0" "http://www.example.org/datasets/ADAE/01-701-1023/2.0E0" ...
    ##  $ p: chr  "http://www.example.org/datasets/vocab/ADAE_AEHLT" "http://www.example.org/datasets/vocab/ADAE_TRTEMFL" "http://www.example.org/datasets/vocab/ADAE_TRTA" "http://www.example.org/datasets/vocab/ADAE_AESCONG" ...
    ##  $ o: chr  "HLT_0284" "Y" "Placebo" "N" ...

``` r
records.res$pclean<- gsub(paste0(d2rqbaseURL,"vocab/ADAE_"), "", records.res$p)
knitr::kable(records.res[,c("s", "p","o")])
```

| s                                                        | p                                                     | o                                               |
|:---------------------------------------------------------|:------------------------------------------------------|:------------------------------------------------|
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEHLT>    | HLT\_0284                                       |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_TRTEMFL>  | Y                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_TRTA>     | Placebo                                         |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESCONG>  | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_ADURU>    |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCCSFL>  |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_SEX>      | M                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESOC>    | SKIN AND SUBCUTANEOUS TISSUE DISORDERS          |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESER>    | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_TRTEDT>   | 19237.0E0                                       |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEBODSYS> | SKIN AND SUBCUTANEOUS TISSUE DISORDERS          |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_SAFFL>    | Y                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESDTH>   | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AGE>      | 64.0E0                                          |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCC01FL> |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>     | <http://www.example.org/datasets/vocab/ADAE>    |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_ASTDY>    | 3.0E0                                           |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_STUDYID>  | CDISCPILOT01                                    |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_ASTDT>    | 19212.0E0                                       |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEREL>    | PROBABLE                                        |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEHLGT>   | HLGT\_0192                                      |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_SITEID>   | 701                                             |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_TRTSDT>   | 19210.0E0                                       |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_ASTDTF>   |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESCAN>   | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AGEGR1N>  | 1.0E0                                           |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCC02FL> |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AELLT>    | LOCALIZED ERYTHEMA                              |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESEV>    | MODERATE                                        |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_TRTAN>    | 0.0E0                                           |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESOD>    | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_USUBJID>  | 01-701-1023                                     |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEACN>    |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEOUT>    | NOT RECOVERED/NOT RESOLVED                      |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AEDECOD>  | ERYTHEMA                                        |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_CQ01NAM>  | DERMATOLOGIC EVENTS                             |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESEQ>    | 2.0E0                                           |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESHOSP>  | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESLIFE>  | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCCPFL>  |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AESDISAB> | N                                               |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCC03FL> |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCCFL>   |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AOCC04FL> |                                                 |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AETERM>   | ERYTHEMA                                        |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_RACE>     | WHITE                                           |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.w3.org/2000/01/rdf-schema#label>          | ADAE \#01-701-1023/2.0E0                        |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_AGEGR1>   | \<65                                            |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.example.org/datasets/vocab/ADAE_RACEN>    | 1.0E0                                           |
| <http://www.example.org/datasets/ADAE/01-701-1023/2.0E0> | <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>     | <http://www.w3.org/2000/01/rdf-schema#Resource> |
