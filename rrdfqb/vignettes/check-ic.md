---
title: "Execute SPARQL integrity constraints on a data cube"
author: "mja@statgroup.dk"
date: "2016-06-29"
vignette: >
  %\VignetteIndexEntry{Execute SPARQL integrity constraints on a data cube}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
---


## Checking two existing cube


```r
library(rrdf)
```

```
## Loading required package: rJava
```

```
## Loading required package: methods
```

```
## Loading required package: rrdflibs
```

```r
library(rrdfqb)
```

```
## Loading required package: xlsx
```

```
## Loading required package: xlsxjars
```

```
## Loading required package: RCurl
```

```
## Loading required package: bitops
```

```
## 
## Attaching package: 'RCurl'
```

```
## The following object is masked from 'package:rJava':
## 
##     clone
```

```
## Loading required package: rrdfancillary
```

```r
cube.vocabulary.ttl <- file.path(system.file("extdata/cube-vocabulary-rdf", "cube.ttl", package="rrdfqb") )
cubevoc<- load.rdf( cube.vocabulary.ttl, format="TURTLE" )

qbfile1<- system.file("extdata/sample-rdf", "example.ttl", package="rrdfqb")
cube1<- load.rdf( qbfile1, format="TURTLE")

cubeData1<- combine.rdf( cube1, cubevoc)
forsparqlprefix<-'
prefix rdf:            <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix rdfs:           <http://www.w3.org/2000/01/rdf-schema#>
prefix owl:            <http://www.w3.org/2002/07/owl#>
prefix xsd:            <http://www.w3.org/2001/XMLSchema#>
prefix skos:           <http://www.w3.org/2004/02/skos/core#>
prefix foaf:           <http://xmlns.com/foaf/0.1/>
prefix scovo:          <http://purl.org/NET/scovo#>
prefix void:           <http://rdfs.org/ns/void#>
prefix qb:             <http://purl.org/linked-data/cube#>
prefix dcterms:        <http://purl.org/dc/terms/>

prefix void:     <http://rdfs.org/ns/void#>
prefix dct:      <http://purl.org/dc/terms/>
prefix org:      <http://www.w3.org/ns/org#>
prefix admingeo: <http://data.ordnancesurvey.co.uk/ontology/admingeo/>
prefix interval: <http://reference.data.gov.uk/def/intervals/>


prefix sdmx-concept:    <http://purl.org/linked-data/sdmx/2009/concept#>
prefix sdmx-dimension:  <http://purl.org/linked-data/sdmx/2009/dimension#>
prefix sdmx-attribute:  <http://purl.org/linked-data/sdmx/2009/attribute#>
prefix sdmx-measure:    <http://purl.org/linked-data/sdmx/2009/measure#>
prefix sdmx-metadata:   <http://purl.org/linked-data/sdmx/2009/metadata#>
prefix sdmx-code:       <http://purl.org/linked-data/sdmx/2009/code#>
prefix sdmx-subject:    <http://purl.org/linked-data/sdmx/2009/subject#>

prefix ex-geo:   <http://example.org/geo#>
prefix eg:       <http://example.org/ns#>
'

icres1<- RunQbIC( cubeData1, forsparqlprefix )
```

```
## Executing IC-1.  Unique DataSet
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-2. Unique DSD
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-3. DSD includes measure
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-4. Dimensions have range
```

```
##  -- 1 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-5. Concept dimensions have code lists
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-6. Only attributes may be optional
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-7. Slice Keys must be declared
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-8. Slice Keys consistent with DSD
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-9. Unique slice structure
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-10. Slice dimensions complete
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-11. All dimensions required
```

```
##  -- 48 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-12. No duplicate observations
```

```
##  -- 120 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-13. Required attributes
```

```
##  -- 24 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-14. All measures present
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-15. Measure dimension consistent
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-16. Single measure on measure dimension observation
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-17. All measures present in measures dimension cube
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-18. Consistent data set links
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-19a. Codes from code list
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## Executing IC-19b. Codes from code list
```

```
##  -- 0 rows returned (0 is pass, >0 fail)
```

```
## IC-20 and IC-21 are currently not implemented
```

```r
knitr::kable(icres1)
```



|ictitle                                                | icfail|
|:------------------------------------------------------|------:|
|IC-1.  Unique DataSet                                  |      0|
|IC-2. Unique DSD                                       |      0|
|IC-3. DSD includes measure                             |      0|
|IC-4. Dimensions have range                            |      1|
|IC-5. Concept dimensions have code lists               |      0|
|IC-6. Only attributes may be optional                  |      0|
|IC-7. Slice Keys must be declared                      |      0|
|IC-8. Slice Keys consistent with DSD                   |      0|
|IC-9. Unique slice structure                           |      0|
|IC-10. Slice dimensions complete                       |      0|
|IC-11. All dimensions required                         |     48|
|IC-12. No duplicate observations                       |    120|
|IC-13. Required attributes                             |     24|
|IC-14. All measures present                            |      0|
|IC-15. Measure dimension consistent                    |      0|
|IC-16. Single measure on measure dimension observation |      0|
|IC-17. All measures present in measures dimension cube |      0|
|IC-18. Consistent data set links                       |      0|
|IC-19a. Codes from code list                           |      0|
|IC-19b. Codes from code list                           |      0|

The file example-fails-IC14.ttl is example.ttl with a few triples added to make the cube non conformant with the intregity constaints.


```r
qbfile2<- system.file("extdata/sample-rdf", "example-fails-IC14.ttl", package="rrdfqb")
cube2<- load.rdf( qbfile2, format="TURTLE")

cube.vocabulary.ttl <- file.path(system.file("extdata/cube-vocabulary-rdf", "cube.ttl", package="rrdfqb") )
cubevoc<- load.rdf( cube.vocabulary.ttl, format="TURTLE" )

cubeData2<- combine.rdf( cube2, cubevoc)

icres2<- RunQbIC( cubeData2, forsparqlprefix, doForIC=c("ic-14") )
```

```
## Executing IC-14. All measures present
```

```
##  -- 23 rows returned (0 is pass, >0 fail)
```

```
## IC-20 and IC-21 are currently not implemented
```

```r
knitr::kable(icres2)
```



|ictitle                     | icfail|
|:---------------------------|------:|
|IC-14. All measures present |     23|

