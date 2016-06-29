Introduction
------------

This vignette shows - the procedure codelist

Setup
=====

``` r
library(rrdfancillary)
devtools::load_all(pkg="../..")
```

    ## Loading rrdfqbcrnd0

``` r
library(rrdfqb)
```

Create RDF data cube
====================

The RDF data cube will be created from two data.frames containing data and metadata.

Define data
-----------

The data are defined as data frame, and the data frame is displayed.

``` r
thisGetDescrStatProcedure<- GetDescrStatProcedure()
procedureName<- gsub( "code:procedure-", "", names(thisGetDescrStatProcedure))
obsData<- data.frame(
  category=rep( "AA-group", length(procedureName)),
  procedure=procedureName,
  factor=rep( "VARA", length(procedureName)),
  unit=rep( "Not given", length(procedureName)),
  denominator=rep( " ", length(procedureName)),
  measure=seq(length(procedureName)),
  stringsAsFactors=FALSE  )
knitr::kable(obsData)
```

| category | procedure     | factor | unit      | denominator |  measure|
|:---------|:--------------|:-------|:----------|:------------|--------:|
| AA-group | mean          | VARA   | Not given |             |        1|
| AA-group | stddev        | VARA   | Not given |             |        2|
| AA-group | stdev         | VARA   | Not given |             |        3|
| AA-group | std           | VARA   | Not given |             |        4|
| AA-group | median        | VARA   | Not given |             |        5|
| AA-group | min           | VARA   | Not given |             |        6|
| AA-group | max           | VARA   | Not given |             |        7|
| AA-group | n             | VARA   | Not given |             |        8|
| AA-group | q1            | VARA   | Not given |             |        9|
| AA-group | q3            | VARA   | Not given |             |       10|
| AA-group | count         | VARA   | Not given |             |       11|
| AA-group | countdistinct | VARA   | Not given |             |       12|
| AA-group | percent       | VARA   | Not given |             |       13|

Define meta data
----------------

The metadata used for generating the RDF data cube are also defined as data frame and displayed.

``` r
cubeMetadata<- data.frame(
  compType=c("dimension", "dimension", "dimension", "unit", "denominator", "measure", "metadata"),
  compName=c("category", "procedure", "factor", "attribute", "attribute", "measure", "domainName"),
  codeType=c("DATA", "DATA", "DATA", " ", " ", "<NA>","<NA>"),
  nciDomainValue=c(" "," "," "," ", " ", " "," "),
  compLabel=c("Category", "Statistical procedure", "Type of procedure", "Result", "Unit", "Denominator", "EXAMPLE"),
  Comment=c(" "," "," "," "," "," "," "),
  stringsAsFactors=FALSE  )
knitr::kable(cubeMetadata)
```

| compType    | compName   | codeType | nciDomainValue | compLabel             | Comment |
|:------------|:-----------|:---------|:---------------|:----------------------|:--------|
| dimension   | category   | DATA     |                | Category              |         |
| dimension   | procedure  | DATA     |                | Statistical procedure |         |
| dimension   | factor     | DATA     |                | Type of procedure     |         |
| unit        | attribute  |          |                | Result                |         |
| denominator | attribute  |          |                | Unit                  |         |
| measure     | measure    | <NA>     |                | Denominator           |         |
| metadata    | domainName | <NA>     |                | EXAMPLE               |         |

Create RDF data cube
--------------------

The RDF data cube for the data above is created using

``` r
outcube<- BuildCubeFromDataFrames(cubeMetadata, obsData )
```

    ## !!!!!!!!!
    ## !!!!!!!!!
    ## !!!!!!!!!

This shows a simple use of the BuildCubeFromDataFrames function. The warning message from log4j can be ignored.

The RDF data cube is serialized in turtle format and stored as a text file in

``` r
cat(normalizePath(outcube),"\n")
```

    ## /tmp/Rtmpk9iV97/DC-EXAMPLE-R-V-0-0-0.ttl

Query the cube using SPARQL
===========================

Now take a look at the generated cubes by loading the turle file.

``` r
dataCubeFile<- outcube
```

The rest of the code only depends on the value of dataCubeFile. The code demonstrates the use of the rrdf library.

``` r
cube <- new.rdf()  # Initialize
temp<-load.rdf(dataCubeFile, format="TURTLE", appendTo= cube)
summarize.rdf(cube)
```

    ## [1] "Number of triples: 370"

The next statements are needed for the current implementation of the cube, and may change in future versions.

``` r
## TODO: reconsider the use of domain specific prefixes
dsdName<- GetDsdNameFromCube( cube )
domainName<- GetDomainNameFromCube( cube )
cat("dsdName ", dsdName, ", domainName ", domainName, "\n" )
```

    ## dsdName  dsd-EXAMPLE , domainName  EXAMPLE

``` r
prefixlist<- Get.prefixlist.from.df(GetForSparqlPrefix.as.df(domainName=domainName))
forsparqlprefix<- GetForSparqlPrefix( domainName )
cat(forsparqlprefix,"\n")
```

    ## prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    ## prefix skos: <http://www.w3.org/2004/02/skos/core#>
    ## prefix prov: <http://www.w3.org/ns/prov#>
    ## prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    ## prefix dcat: <http://www.w3.org/ns/dcat#>
    ## prefix owl: <http://www.w3.org/2002/07/owl#>
    ## prefix xsd: <http://www.w3.org/2001/XMLSchema#>
    ## prefix pav: <http://purl.org/pav>
    ## prefix dc: <http://purl.org/dc/elements/1.1/>
    ## prefix dct: <http://purl.org/dc/terms/>
    ## prefix mms: <http://rdf.cdisc.org/mms#>
    ## prefix cts: <http://rdf.cdisc.org/ct/schema#>
    ## prefix cdiscs: <http://rdf.cdisc.org/std/schema#>
    ## prefix cdash-1-1: <http://rdf.cdisc.org/std/cdash-1-1#>
    ## prefix cdashct: <http://rdf.cdisc.org/cdash-terminology#>
    ## prefix sdtmct: <http://rdf.cdisc.org/sdtm-terminology#>
    ## prefix sdtm-1-2: <http://rdf.cdisc.org/std/sdtm-1-2#>
    ## prefix sdtm-1-3: <http://rdf.cdisc.org/std/sdtm-1-3#>
    ## prefix sdtms-1-3: <http://rdf.cdisc.org/sdtm-1-3/schema#>
    ## prefix sdtmig-3-1-2: <http://rdf.cdisc.org/std/sdtmig-3-1-2#>
    ## prefix sdtmig-3-1-3: <http://rdf.cdisc.org/std/sdtmig-3-1-3#>
    ## prefix sendct: <http://rdf.cdisc.org/send-terminology#>
    ## prefix sendig-3-0: <http://rdf.cdisc.org/std/sendig-3-0#>
    ## prefix adamct: <http://rdf.cdisc.org/adam-terminology#>
    ## prefix adam-2-1: <http://rdf.cdisc.org/std/adam-2-1#>
    ## prefix adamig-1-0: <http://rdf.cdisc.org/std/adamig-1-0#>
    ## prefix adamvr-1-2: <http://rdf.cdisc.org/std/adamvr-1-2#>
    ## prefix qb: <http://purl.org/linked-data/cube#>
    ## prefix rrdfqbcrnd0: <http://www.example.org/rrdfqbcrnd0/>
    ## prefix code: <http://www.example.org/dc/code/>
    ## prefix dccs: <http://www.example.org/dc/example/dccs/>
    ## prefix ds: <http://www.example.org/dc/example/ds/>
    ## prefix crnd-dimension: <http://www.example.org/dc/dimension#>
    ## prefix crnd-attribute: <http://www.example.org/dc/attribute#>
    ## prefix crnd-measure: <http://www.example.org/dc/measure#>
    ## 

The variable forsparqlprefix contains the prefix statements applicable for the present data cube. The use of prefixes makes the SPARQL query shorter, and more readable. The present version of the package defines namespaces dccs: and ds: where the domainname is included. TODO: Consider other approach for including the domainname, or use other concept.

Add `rdfs:seeAlso` for descriptive statistics
---------------------------------------------

``` r
        add.triple(cube,
                   paste0(prefixlist$prefixCODE, "procedure-median"),
                   paste0(prefixlist$prefixRDFS,"seeAlso" ),
                   "purl.obolibrary.org/obo/OBI_0200119")
        add.triple(cube,
                   paste0(prefixlist$prefixCODE, "procedure-stddev"),
                   paste0(prefixlist$prefixRDFS,"seeAlso" ),
                   "purl.obolibrary.org/obo/STATO_0000037")
        add.triple(cube,
                   paste0(prefixlist$prefixCODE, "procedure-mean"),
                   paste0(prefixlist$prefixRDFS,"seeAlso" ),
                   "purl.obolibrary.org/obo/IAO_0000125")
```

Getting all codelists as data.frame
-----------------------------------

The SPARQL query for codelists are shown in the next output.

    ## prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    ## prefix skos: <http://www.w3.org/2004/02/skos/core#>
    ## prefix prov: <http://www.w3.org/ns/prov#>
    ## prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    ## prefix dcat: <http://www.w3.org/ns/dcat#>
    ## prefix owl: <http://www.w3.org/2002/07/owl#>
    ## prefix xsd: <http://www.w3.org/2001/XMLSchema#>
    ## prefix pav: <http://purl.org/pav>
    ## prefix dc: <http://purl.org/dc/elements/1.1/>
    ## prefix dct: <http://purl.org/dc/terms/>
    ## prefix mms: <http://rdf.cdisc.org/mms#>
    ## prefix cts: <http://rdf.cdisc.org/ct/schema#>
    ## prefix cdiscs: <http://rdf.cdisc.org/std/schema#>
    ## prefix cdash-1-1: <http://rdf.cdisc.org/std/cdash-1-1#>
    ## prefix cdashct: <http://rdf.cdisc.org/cdash-terminology#>
    ## prefix sdtmct: <http://rdf.cdisc.org/sdtm-terminology#>
    ## prefix sdtm-1-2: <http://rdf.cdisc.org/std/sdtm-1-2#>
    ## prefix sdtm-1-3: <http://rdf.cdisc.org/std/sdtm-1-3#>
    ## prefix sdtms-1-3: <http://rdf.cdisc.org/sdtm-1-3/schema#>
    ## prefix sdtmig-3-1-2: <http://rdf.cdisc.org/std/sdtmig-3-1-2#>
    ## prefix sdtmig-3-1-3: <http://rdf.cdisc.org/std/sdtmig-3-1-3#>
    ## prefix sendct: <http://rdf.cdisc.org/send-terminology#>
    ## prefix sendig-3-0: <http://rdf.cdisc.org/std/sendig-3-0#>
    ## prefix adamct: <http://rdf.cdisc.org/adam-terminology#>
    ## prefix adam-2-1: <http://rdf.cdisc.org/std/adam-2-1#>
    ## prefix adamig-1-0: <http://rdf.cdisc.org/std/adamig-1-0#>
    ## prefix adamvr-1-2: <http://rdf.cdisc.org/std/adamvr-1-2#>
    ## prefix qb: <http://purl.org/linked-data/cube#>
    ## prefix rrdfqbcrnd0: <http://www.example.org/rrdfqbcrnd0/>
    ## prefix code: <http://www.example.org/dc/code/>
    ## prefix dccs: <http://www.example.org/dc/example/dccs/>
    ## prefix ds: <http://www.example.org/dc/example/ds/>
    ## prefix crnd-dimension: <http://www.example.org/dc/dimension#>
    ## prefix crnd-attribute: <http://www.example.org/dc/attribute#>
    ## prefix crnd-measure: <http://www.example.org/dc/measure#>
    ##  
    ## select distinct ?DataStructureDefinition ?dimension ?cprefLabel ?cl ?clprefLabel ?vn ?vct ?vnop ?vnval
    ## where {
    ##    ?DataStructureDefinition a qb:DataStructureDefinition ;
    ##         qb:component ?component .
    ##    ?component a qb:ComponentSpecification .
    ##    ?component qb:dimension ?dimension .
    ## 
    ##    ?dimension qb:codeList ?c .
    ##    OPTIONAL { ?c skos:prefLabel ?cprefLabel .   }
    ##    OPTIONAL { ?c rrdfqbcrnd0:DataSetRefD2RQ ?vnop . }
    ##    OPTIONAL { ?c rrdfqbcrnd0:R-columnname ?vn . }
    ##    OPTIONAL { ?c rrdfqbcrnd0:codeType     ?vct .          }
    ## 
    ##    ?c skos:hasTopConcept ?cl .
    ##    OPTIONAL { ?cl skos:prefLabel ?clprefLabel . }
    ##    OPTIONAL { ?cl rrdfqbcrnd0:R-selectionoperator ?vnop . }
    ##    OPTIONAL { ?cl rrdfqbcrnd0:R-selectionvalue ?vnval .   }
    ##  values ( ?DataStructureDefinition ) {
    ## (ds:dsd-EXAMPLE)
    ## } 
    ## }
    ## order by ?dimension ?cl ?dimensionrefLabel

Executing the SPARQL query gives the code list as a data frame.

    ##      vn                     clc   clprefLabel
    ## 1  <NA>       category-AA-group      AA-group
    ## 2  <NA>          category-_ALL_         _ALL_
    ## 3  <NA>      category-_NONMISS_     _NONMISS_
    ## 4  <NA>             factor-VARA          VARA
    ## 5  <NA>            factor-_ALL_         _ALL_
    ## 6  <NA>        factor-_NONMISS_     _NONMISS_
    ## 7  <NA>         procedure-count         count
    ## 8  <NA> procedure-countdistinct countdistinct
    ## 9  <NA>           procedure-max           max
    ## 10 <NA>          procedure-mean          mean
    ## 11 <NA>        procedure-median        median
    ## 12 <NA>           procedure-min           min
    ## 13 <NA>             procedure-n             n
    ## 14 <NA>       procedure-percent       percent
    ## 15 <NA>            procedure-q1            q1
    ## 16 <NA>            procedure-q3            q3
    ## 17 <NA>           procedure-std           std
    ## 18 <NA>        procedure-stddev        stddev
    ## 19 <NA>         procedure-stdev         stdev

| vn  | clc                     | clprefLabel   |
|:----|:------------------------|:--------------|
| NA  | category-AA-group       | AA-group      |
| NA  | category-*ALL*          | *ALL*         |
| NA  | category-*NONMISS*      | *NONMISS*     |
| NA  | factor-VARA             | VARA          |
| NA  | factor-*ALL*            | *ALL*         |
| NA  | factor-*NONMISS*        | *NONMISS*     |
| NA  | procedure-count         | count         |
| NA  | procedure-countdistinct | countdistinct |
| NA  | procedure-max           | max           |
| NA  | procedure-mean          | mean          |
| NA  | procedure-median        | median        |
| NA  | procedure-min           | min           |
| NA  | procedure-n             | n             |
| NA  | procedure-percent       | percent       |
| NA  | procedure-q1            | q1            |
| NA  | procedure-q3            | q3            |
| NA  | procedure-std           | std           |
| NA  | procedure-stddev        | stddev        |
| NA  | procedure-stdev         | stdev         |

Getting the procedure codelist as data.frame
--------------------------------------------

    ## prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    ## prefix skos: <http://www.w3.org/2004/02/skos/core#>
    ## prefix prov: <http://www.w3.org/ns/prov#>
    ## prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    ## prefix dcat: <http://www.w3.org/ns/dcat#>
    ## prefix owl: <http://www.w3.org/2002/07/owl#>
    ## prefix xsd: <http://www.w3.org/2001/XMLSchema#>
    ## prefix pav: <http://purl.org/pav>
    ## prefix dc: <http://purl.org/dc/elements/1.1/>
    ## prefix dct: <http://purl.org/dc/terms/>
    ## prefix mms: <http://rdf.cdisc.org/mms#>
    ## prefix cts: <http://rdf.cdisc.org/ct/schema#>
    ## prefix cdiscs: <http://rdf.cdisc.org/std/schema#>
    ## prefix cdash-1-1: <http://rdf.cdisc.org/std/cdash-1-1#>
    ## prefix cdashct: <http://rdf.cdisc.org/cdash-terminology#>
    ## prefix sdtmct: <http://rdf.cdisc.org/sdtm-terminology#>
    ## prefix sdtm-1-2: <http://rdf.cdisc.org/std/sdtm-1-2#>
    ## prefix sdtm-1-3: <http://rdf.cdisc.org/std/sdtm-1-3#>
    ## prefix sdtms-1-3: <http://rdf.cdisc.org/sdtm-1-3/schema#>
    ## prefix sdtmig-3-1-2: <http://rdf.cdisc.org/std/sdtmig-3-1-2#>
    ## prefix sdtmig-3-1-3: <http://rdf.cdisc.org/std/sdtmig-3-1-3#>
    ## prefix sendct: <http://rdf.cdisc.org/send-terminology#>
    ## prefix sendig-3-0: <http://rdf.cdisc.org/std/sendig-3-0#>
    ## prefix adamct: <http://rdf.cdisc.org/adam-terminology#>
    ## prefix adam-2-1: <http://rdf.cdisc.org/std/adam-2-1#>
    ## prefix adamig-1-0: <http://rdf.cdisc.org/std/adamig-1-0#>
    ## prefix adamvr-1-2: <http://rdf.cdisc.org/std/adamvr-1-2#>
    ## prefix qb: <http://purl.org/linked-data/cube#>
    ## prefix rrdfqbcrnd0: <http://www.example.org/rrdfqbcrnd0/>
    ## prefix code: <http://www.example.org/dc/code/>
    ## prefix dccs: <http://www.example.org/dc/example/dccs/>
    ## prefix ds: <http://www.example.org/dc/example/ds/>
    ## prefix crnd-dimension: <http://www.example.org/dc/dimension#>
    ## prefix crnd-attribute: <http://www.example.org/dc/attribute#>
    ## prefix crnd-measure: <http://www.example.org/dc/measure#>
    ##  
    ## select ?s ?p ?o
    ## where { 
    ## ?s ?p ?o .
    ## ?s a code:Procedure
    ##  }    
    ## 

Executing the SPARQL query gives the code list as a data frame.

    ##                               s                 p
    ## 1           code:procedure-mean      rdfs:seeAlso
    ## 2           code:procedure-mean skos:topConceptOf
    ## 3           code:procedure-mean    skos:prefLabel
    ## 4           code:procedure-mean     skos:inScheme
    ## 5           code:procedure-mean      rdfs:comment
    ## 6           code:procedure-mean          rdf:type
    ## 7           code:procedure-mean          rdf:type
    ## 8              code:procedure-n skos:topConceptOf
    ## 9              code:procedure-n    skos:prefLabel
    ## 10             code:procedure-n     skos:inScheme
    ## 11             code:procedure-n      rdfs:comment
    ## 12             code:procedure-n          rdf:type
    ## 13             code:procedure-n          rdf:type
    ## 14            code:procedure-q3 skos:topConceptOf
    ## 15            code:procedure-q3    skos:prefLabel
    ## 16            code:procedure-q3     skos:inScheme
    ## 17            code:procedure-q3      rdfs:comment
    ## 18            code:procedure-q3          rdf:type
    ## 19            code:procedure-q3          rdf:type
    ## 20 code:procedure-countdistinct skos:topConceptOf
    ## 21 code:procedure-countdistinct    skos:prefLabel
    ## 22 code:procedure-countdistinct     skos:inScheme
    ## 23 code:procedure-countdistinct      rdfs:comment
    ## 24 code:procedure-countdistinct          rdf:type
    ## 25 code:procedure-countdistinct          rdf:type
    ## 26         code:procedure-count skos:topConceptOf
    ## 27         code:procedure-count    skos:prefLabel
    ## 28         code:procedure-count     skos:inScheme
    ## 29         code:procedure-count      rdfs:comment
    ## 30         code:procedure-count          rdf:type
    ## 31         code:procedure-count          rdf:type
    ## 32        code:procedure-median      rdfs:seeAlso
    ## 33        code:procedure-median skos:topConceptOf
    ## 34        code:procedure-median    skos:prefLabel
    ## 35        code:procedure-median     skos:inScheme
    ## 36        code:procedure-median      rdfs:comment
    ## 37        code:procedure-median          rdf:type
    ## 38        code:procedure-median          rdf:type
    ## 39         code:procedure-stdev skos:topConceptOf
    ## 40         code:procedure-stdev    skos:prefLabel
    ## 41         code:procedure-stdev     skos:inScheme
    ## 42         code:procedure-stdev      rdfs:comment
    ## 43         code:procedure-stdev          rdf:type
    ## 44         code:procedure-stdev          rdf:type
    ## 45           code:procedure-std skos:topConceptOf
    ## 46           code:procedure-std    skos:prefLabel
    ## 47           code:procedure-std     skos:inScheme
    ## 48           code:procedure-std      rdfs:comment
    ## 49           code:procedure-std          rdf:type
    ## 50           code:procedure-std          rdf:type
    ## 51            code:procedure-q1 skos:topConceptOf
    ## 52            code:procedure-q1    skos:prefLabel
    ## 53            code:procedure-q1     skos:inScheme
    ## 54            code:procedure-q1      rdfs:comment
    ## 55            code:procedure-q1          rdf:type
    ## 56            code:procedure-q1          rdf:type
    ## 57       code:procedure-percent skos:topConceptOf
    ## 58       code:procedure-percent    skos:prefLabel
    ## 59       code:procedure-percent     skos:inScheme
    ## 60       code:procedure-percent      rdfs:comment
    ## 61       code:procedure-percent          rdf:type
    ## 62       code:procedure-percent          rdf:type
    ## 63           code:procedure-max skos:topConceptOf
    ## 64           code:procedure-max    skos:prefLabel
    ## 65           code:procedure-max     skos:inScheme
    ## 66           code:procedure-max      rdfs:comment
    ## 67           code:procedure-max          rdf:type
    ## 68           code:procedure-max          rdf:type
    ## 69        code:procedure-stddev      rdfs:seeAlso
    ## 70        code:procedure-stddev skos:topConceptOf
    ## 71        code:procedure-stddev    skos:prefLabel
    ## 72        code:procedure-stddev     skos:inScheme
    ## 73        code:procedure-stddev      rdfs:comment
    ## 74        code:procedure-stddev          rdf:type
    ## 75        code:procedure-stddev          rdf:type
    ## 76           code:procedure-min skos:topConceptOf
    ## 77           code:procedure-min    skos:prefLabel
    ## 78           code:procedure-min     skos:inScheme
    ## 79           code:procedure-min      rdfs:comment
    ## 80           code:procedure-min          rdf:type
    ## 81           code:procedure-min          rdf:type
    ## 82            code:procedure-q3          rdf:type
    ## 83        code:procedure-stddev          rdf:type
    ## 84         code:procedure-stdev          rdf:type
    ## 85          code:procedure-mean          rdf:type
    ## 86            code:procedure-q1          rdf:type
    ## 87           code:procedure-std          rdf:type
    ## 88         code:procedure-count          rdf:type
    ## 89        code:procedure-median          rdf:type
    ## 90       code:procedure-percent          rdf:type
    ## 91 code:procedure-countdistinct          rdf:type
    ## 92           code:procedure-min          rdf:type
    ## 93           code:procedure-max          rdf:type
    ## 94             code:procedure-n          rdf:type
    ##                                        o
    ## 1    purl.obolibrary.org/obo/IAO_0000125
    ## 2                         code:procedure
    ## 3                                   mean
    ## 4                         code:procedure
    ## 5            Descriptive statistics mean
    ## 6                           skos:Concept
    ## 7                         code:Procedure
    ## 8                         code:procedure
    ## 9                                      n
    ## 10                        code:procedure
    ## 11              Descriptive statistics n
    ## 12                          skos:Concept
    ## 13                        code:Procedure
    ## 14                        code:procedure
    ## 15                                    q3
    ## 16                        code:procedure
    ## 17             Descriptive statistics q3
    ## 18                          skos:Concept
    ## 19                        code:Procedure
    ## 20                        code:procedure
    ## 21                         countdistinct
    ## 22                        code:procedure
    ## 23  Descriptive statistics countdistinct
    ## 24                          skos:Concept
    ## 25                        code:Procedure
    ## 26                        code:procedure
    ## 27                                 count
    ## 28                        code:procedure
    ## 29          Descriptive statistics count
    ## 30                          skos:Concept
    ## 31                        code:Procedure
    ## 32   purl.obolibrary.org/obo/OBI_0200119
    ## 33                        code:procedure
    ## 34                                median
    ## 35                        code:procedure
    ## 36         Descriptive statistics median
    ## 37                          skos:Concept
    ## 38                        code:Procedure
    ## 39                        code:procedure
    ## 40                                 stdev
    ## 41                        code:procedure
    ## 42          Descriptive statistics stdev
    ## 43                          skos:Concept
    ## 44                        code:Procedure
    ## 45                        code:procedure
    ## 46                                   std
    ## 47                        code:procedure
    ## 48            Descriptive statistics std
    ## 49                          skos:Concept
    ## 50                        code:Procedure
    ## 51                        code:procedure
    ## 52                                    q1
    ## 53                        code:procedure
    ## 54             Descriptive statistics q1
    ## 55                          skos:Concept
    ## 56                        code:Procedure
    ## 57                        code:procedure
    ## 58                               percent
    ## 59                        code:procedure
    ## 60        Descriptive statistics percent
    ## 61                          skos:Concept
    ## 62                        code:Procedure
    ## 63                        code:procedure
    ## 64                                   max
    ## 65                        code:procedure
    ## 66            Descriptive statistics max
    ## 67                          skos:Concept
    ## 68                        code:Procedure
    ## 69 purl.obolibrary.org/obo/STATO_0000037
    ## 70                        code:procedure
    ## 71                                stddev
    ## 72                        code:procedure
    ## 73         Descriptive statistics stddev
    ## 74                          skos:Concept
    ## 75                        code:Procedure
    ## 76                        code:procedure
    ## 77                                   min
    ## 78                        code:procedure
    ## 79            Descriptive statistics min
    ## 80                          skos:Concept
    ## 81                        code:Procedure
    ## 82                         rdfs:Resource
    ## 83                         rdfs:Resource
    ## 84                         rdfs:Resource
    ## 85                         rdfs:Resource
    ## 86                         rdfs:Resource
    ## 87                         rdfs:Resource
    ## 88                         rdfs:Resource
    ## 89                         rdfs:Resource
    ## 90                         rdfs:Resource
    ## 91                         rdfs:Resource
    ## 92                         rdfs:Resource
    ## 93                         rdfs:Resource
    ## 94                         rdfs:Resource

| s                            | p                 | o                                      |
|:-----------------------------|:------------------|:---------------------------------------|
| code:procedure-mean          | rdfs:seeAlso      | purl.obolibrary.org/obo/IAO\_0000125   |
| code:procedure-mean          | skos:topConceptOf | code:procedure                         |
| code:procedure-mean          | skos:prefLabel    | mean                                   |
| code:procedure-mean          | skos:inScheme     | code:procedure                         |
| code:procedure-mean          | rdfs:comment      | Descriptive statistics mean            |
| code:procedure-mean          | rdf:type          | skos:Concept                           |
| code:procedure-mean          | rdf:type          | code:Procedure                         |
| code:procedure-n             | skos:topConceptOf | code:procedure                         |
| code:procedure-n             | skos:prefLabel    | n                                      |
| code:procedure-n             | skos:inScheme     | code:procedure                         |
| code:procedure-n             | rdfs:comment      | Descriptive statistics n               |
| code:procedure-n             | rdf:type          | skos:Concept                           |
| code:procedure-n             | rdf:type          | code:Procedure                         |
| code:procedure-q3            | skos:topConceptOf | code:procedure                         |
| code:procedure-q3            | skos:prefLabel    | q3                                     |
| code:procedure-q3            | skos:inScheme     | code:procedure                         |
| code:procedure-q3            | rdfs:comment      | Descriptive statistics q3              |
| code:procedure-q3            | rdf:type          | skos:Concept                           |
| code:procedure-q3            | rdf:type          | code:Procedure                         |
| code:procedure-countdistinct | skos:topConceptOf | code:procedure                         |
| code:procedure-countdistinct | skos:prefLabel    | countdistinct                          |
| code:procedure-countdistinct | skos:inScheme     | code:procedure                         |
| code:procedure-countdistinct | rdfs:comment      | Descriptive statistics countdistinct   |
| code:procedure-countdistinct | rdf:type          | skos:Concept                           |
| code:procedure-countdistinct | rdf:type          | code:Procedure                         |
| code:procedure-count         | skos:topConceptOf | code:procedure                         |
| code:procedure-count         | skos:prefLabel    | count                                  |
| code:procedure-count         | skos:inScheme     | code:procedure                         |
| code:procedure-count         | rdfs:comment      | Descriptive statistics count           |
| code:procedure-count         | rdf:type          | skos:Concept                           |
| code:procedure-count         | rdf:type          | code:Procedure                         |
| code:procedure-median        | rdfs:seeAlso      | purl.obolibrary.org/obo/OBI\_0200119   |
| code:procedure-median        | skos:topConceptOf | code:procedure                         |
| code:procedure-median        | skos:prefLabel    | median                                 |
| code:procedure-median        | skos:inScheme     | code:procedure                         |
| code:procedure-median        | rdfs:comment      | Descriptive statistics median          |
| code:procedure-median        | rdf:type          | skos:Concept                           |
| code:procedure-median        | rdf:type          | code:Procedure                         |
| code:procedure-stdev         | skos:topConceptOf | code:procedure                         |
| code:procedure-stdev         | skos:prefLabel    | stdev                                  |
| code:procedure-stdev         | skos:inScheme     | code:procedure                         |
| code:procedure-stdev         | rdfs:comment      | Descriptive statistics stdev           |
| code:procedure-stdev         | rdf:type          | skos:Concept                           |
| code:procedure-stdev         | rdf:type          | code:Procedure                         |
| code:procedure-std           | skos:topConceptOf | code:procedure                         |
| code:procedure-std           | skos:prefLabel    | std                                    |
| code:procedure-std           | skos:inScheme     | code:procedure                         |
| code:procedure-std           | rdfs:comment      | Descriptive statistics std             |
| code:procedure-std           | rdf:type          | skos:Concept                           |
| code:procedure-std           | rdf:type          | code:Procedure                         |
| code:procedure-q1            | skos:topConceptOf | code:procedure                         |
| code:procedure-q1            | skos:prefLabel    | q1                                     |
| code:procedure-q1            | skos:inScheme     | code:procedure                         |
| code:procedure-q1            | rdfs:comment      | Descriptive statistics q1              |
| code:procedure-q1            | rdf:type          | skos:Concept                           |
| code:procedure-q1            | rdf:type          | code:Procedure                         |
| code:procedure-percent       | skos:topConceptOf | code:procedure                         |
| code:procedure-percent       | skos:prefLabel    | percent                                |
| code:procedure-percent       | skos:inScheme     | code:procedure                         |
| code:procedure-percent       | rdfs:comment      | Descriptive statistics percent         |
| code:procedure-percent       | rdf:type          | skos:Concept                           |
| code:procedure-percent       | rdf:type          | code:Procedure                         |
| code:procedure-max           | skos:topConceptOf | code:procedure                         |
| code:procedure-max           | skos:prefLabel    | max                                    |
| code:procedure-max           | skos:inScheme     | code:procedure                         |
| code:procedure-max           | rdfs:comment      | Descriptive statistics max             |
| code:procedure-max           | rdf:type          | skos:Concept                           |
| code:procedure-max           | rdf:type          | code:Procedure                         |
| code:procedure-stddev        | rdfs:seeAlso      | purl.obolibrary.org/obo/STATO\_0000037 |
| code:procedure-stddev        | skos:topConceptOf | code:procedure                         |
| code:procedure-stddev        | skos:prefLabel    | stddev                                 |
| code:procedure-stddev        | skos:inScheme     | code:procedure                         |
| code:procedure-stddev        | rdfs:comment      | Descriptive statistics stddev          |
| code:procedure-stddev        | rdf:type          | skos:Concept                           |
| code:procedure-stddev        | rdf:type          | code:Procedure                         |
| code:procedure-min           | skos:topConceptOf | code:procedure                         |
| code:procedure-min           | skos:prefLabel    | min                                    |
| code:procedure-min           | skos:inScheme     | code:procedure                         |
| code:procedure-min           | rdfs:comment      | Descriptive statistics min             |
| code:procedure-min           | rdf:type          | skos:Concept                           |
| code:procedure-min           | rdf:type          | code:Procedure                         |
| code:procedure-q3            | rdf:type          | rdfs:Resource                          |
| code:procedure-stddev        | rdf:type          | rdfs:Resource                          |
| code:procedure-stdev         | rdf:type          | rdfs:Resource                          |
| code:procedure-mean          | rdf:type          | rdfs:Resource                          |
| code:procedure-q1            | rdf:type          | rdfs:Resource                          |
| code:procedure-std           | rdf:type          | rdfs:Resource                          |
| code:procedure-count         | rdf:type          | rdfs:Resource                          |
| code:procedure-median        | rdf:type          | rdfs:Resource                          |
| code:procedure-percent       | rdf:type          | rdfs:Resource                          |
| code:procedure-countdistinct | rdf:type          | rdfs:Resource                          |
| code:procedure-min           | rdf:type          | rdfs:Resource                          |
| code:procedure-max           | rdf:type          | rdfs:Resource                          |
| code:procedure-n             | rdf:type          | rdfs:Resource                          |

Get the procedure codelist as turtle with Stato References
----------------------------------------------------------

    ## prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    ## prefix skos: <http://www.w3.org/2004/02/skos/core#>
    ## prefix prov: <http://www.w3.org/ns/prov#>
    ## prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    ## prefix dcat: <http://www.w3.org/ns/dcat#>
    ## prefix owl: <http://www.w3.org/2002/07/owl#>
    ## prefix xsd: <http://www.w3.org/2001/XMLSchema#>
    ## prefix pav: <http://purl.org/pav>
    ## prefix dc: <http://purl.org/dc/elements/1.1/>
    ## prefix dct: <http://purl.org/dc/terms/>
    ## prefix mms: <http://rdf.cdisc.org/mms#>
    ## prefix cts: <http://rdf.cdisc.org/ct/schema#>
    ## prefix cdiscs: <http://rdf.cdisc.org/std/schema#>
    ## prefix cdash-1-1: <http://rdf.cdisc.org/std/cdash-1-1#>
    ## prefix cdashct: <http://rdf.cdisc.org/cdash-terminology#>
    ## prefix sdtmct: <http://rdf.cdisc.org/sdtm-terminology#>
    ## prefix sdtm-1-2: <http://rdf.cdisc.org/std/sdtm-1-2#>
    ## prefix sdtm-1-3: <http://rdf.cdisc.org/std/sdtm-1-3#>
    ## prefix sdtms-1-3: <http://rdf.cdisc.org/sdtm-1-3/schema#>
    ## prefix sdtmig-3-1-2: <http://rdf.cdisc.org/std/sdtmig-3-1-2#>
    ## prefix sdtmig-3-1-3: <http://rdf.cdisc.org/std/sdtmig-3-1-3#>
    ## prefix sendct: <http://rdf.cdisc.org/send-terminology#>
    ## prefix sendig-3-0: <http://rdf.cdisc.org/std/sendig-3-0#>
    ## prefix adamct: <http://rdf.cdisc.org/adam-terminology#>
    ## prefix adam-2-1: <http://rdf.cdisc.org/std/adam-2-1#>
    ## prefix adamig-1-0: <http://rdf.cdisc.org/std/adamig-1-0#>
    ## prefix adamvr-1-2: <http://rdf.cdisc.org/std/adamvr-1-2#>
    ## prefix qb: <http://purl.org/linked-data/cube#>
    ## prefix rrdfqbcrnd0: <http://www.example.org/rrdfqbcrnd0/>
    ## prefix code: <http://www.example.org/dc/code/>
    ## prefix dccs: <http://www.example.org/dc/example/dccs/>
    ## prefix ds: <http://www.example.org/dc/example/ds/>
    ## prefix crnd-dimension: <http://www.example.org/dc/dimension#>
    ## prefix crnd-attribute: <http://www.example.org/dc/attribute#>
    ## prefix crnd-measure: <http://www.example.org/dc/measure#>
    ##  
    ## construct { ?s ?p ?o } 
    ## where { 
    ## { ?s ?p ?o . ?s a code:Procedure. }
    ## union
    ## { ?s ?p ?o . values(?s) {(code:Procedure)} }
    ##  } 
    ## 

The RDF data cube is serialized in turtle format and stored as a text file in

``` r
cat(normalizePath(outcodelist),"\n")
```

    ## /home/ma/projects/rrdfqbcrnd/rrdfqbcrnd0/inst/extdata/sample-rdf/procedure-code-list.ttl

The triples are:

``` r
cat(readLines(procedure.codelist.fn),"\n")
```

    ## @prefix dccs:  <http://www.example.org/dc/example/dccs/> . @prefix sdtms-1-3: <http://rdf.cdisc.org/sdtm-1-3/schema#> . @prefix code:  <http://www.example.org/dc/code/> . @prefix adam-2-1: <http://rdf.cdisc.org/std/adam-2-1#> . @prefix owl:   <http://www.w3.org/2002/07/owl#> . @prefix xsd:   <http://www.w3.org/2001/XMLSchema#> . @prefix skos:  <http://www.w3.org/2004/02/skos/core#> . @prefix cdash-1-1: <http://rdf.cdisc.org/std/cdash-1-1#> . @prefix sdtm-1-3: <http://rdf.cdisc.org/std/sdtm-1-3#> . @prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> . @prefix adamvr-1-2: <http://rdf.cdisc.org/std/adamvr-1-2#> . @prefix crnd-attribute: <http://www.example.org/dc/attribute#> . @prefix sdtm-1-2: <http://rdf.cdisc.org/std/sdtm-1-2#> . @prefix sdtmct: <http://rdf.cdisc.org/sdtm-terminology#> . @prefix ds:    <http://www.example.org/dc/example/ds/> . @prefix qb:    <http://purl.org/linked-data/cube#> . @prefix mms:   <http://rdf.cdisc.org/mms#> . @prefix crnd-dimension: <http://www.example.org/dc/dimension#> . @prefix dct:   <http://purl.org/dc/terms/> . @prefix cdiscs: <http://rdf.cdisc.org/std/schema#> . @prefix dcat:  <http://www.w3.org/ns/dcat#> . @prefix cdashct: <http://rdf.cdisc.org/cdash-terminology#> . @prefix prov:  <http://www.w3.org/ns/prov#> . @prefix sdtmig-3-1-3: <http://rdf.cdisc.org/std/sdtmig-3-1-3#> . @prefix adamig-1-0: <http://rdf.cdisc.org/std/adamig-1-0#> . @prefix crnd-measure: <http://www.example.org/dc/measure#> . @prefix cts:   <http://rdf.cdisc.org/ct/schema#> . @prefix pav:   <http://purl.org/pav> . @prefix sdtmig-3-1-2: <http://rdf.cdisc.org/std/sdtmig-3-1-2#> . @prefix sendig-3-0: <http://rdf.cdisc.org/std/sendig-3-0#> . @prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . @prefix adamct: <http://rdf.cdisc.org/adam-terminology#> . @prefix sendct: <http://rdf.cdisc.org/send-terminology#> . @prefix rrdfqbcrnd0: <http://www.example.org/rrdfqbcrnd0/> . @prefix dc:    <http://purl.org/dc/elements/1.1/> .  code:procedure-q3  a       rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics q3"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "q3"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:Procedure  a        rdfs:Resource , rdfs:Class , owl:Class ;         rdfs:comment     "Specifies the procedure for each observation"@en ;         rdfs:label       "Class for code list: procedure"@en ;         rdfs:seeAlso     code:procedure ;         rdfs:subClassOf  code:Procedure , skos:Concept , rdfs:Resource .  code:procedure-q1  a       rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics q1"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "q1"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-stddev         a                  rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics stddev"@en ;         rdfs:seeAlso       <purl.obolibrary.org/obo/STATO_0000037> ;         skos:inScheme      code:procedure ;         skos:prefLabel     "stddev"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-mean  a     rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics mean"@en ;         rdfs:seeAlso       <purl.obolibrary.org/obo/IAO_0000125> ;         skos:inScheme      code:procedure ;         skos:prefLabel     "mean"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-max  a      rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics max"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "max"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-stdev  a    rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics stdev"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "stdev"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-median         a                  rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics median"@en ;         rdfs:seeAlso       <purl.obolibrary.org/obo/OBI_0200119> ;         skos:inScheme      code:procedure ;         skos:prefLabel     "median"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-std  a      rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics std"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "std"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-count  a    rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics count"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "count"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-countdistinct         a                  rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics countdistinct"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "countdistinct"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-n  a        rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics n"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "n"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-min  a      rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics min"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "min"^^xsd:string ;         skos:topConceptOf  code:procedure .  code:procedure-percent         a                  rdfs:Resource , code:Procedure , skos:Concept ;         rdfs:comment       "Descriptive statistics percent"@en ;         skos:inScheme      code:procedure ;         skos:prefLabel     "percent"^^xsd:string ;         skos:topConceptOf  code:procedure .
