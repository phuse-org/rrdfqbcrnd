---
title: "RDF data cube SPARQL queries"
vignette: >
  %\VignetteIndexEntry{Explore RDF data cube vocabulary}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
output:
  html_document:
    toc: true
    theme: united
  pdf_document:
    toc: true
    highlight: zenburn
  md_document:
    variant: markdown_github
---

# Setup

```r
library(rrdfancillary)
```

```
## Loading required package: rJava
```

```
## Loading required package: methods
```

```
## Loading required package: rrdf
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

# Load example cube and define SPARQL prefixes


```r
qbfile <- file.path(system.file("extdata/sample-rdf", "example-normalized.ttl", package="rrdfqb") )
# qbfile <- file.path(system.file("extdata/sample-rdf", "example.ttl", package="rrdfqb") )
# qbfile <- file.path(system.file("extdata/sample-rdf", "DC-DEMO-sample.ttl", package="rrdfcrndex") )
cube <- new.rdf(ontology=FALSE)
invisible(load.rdf( qbfile, format="TURTLE", cube))

SPARQLprefix<- '
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>  
prefix skos: <http://www.w3.org/2004/02/skos/core#>  
prefix prov: <http://www.w3.org/ns/prov#>  
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>  
prefix dcat: <http://www.w3.org/ns/dcat#>  
prefix owl: <http://www.w3.org/2002/07/owl#>  
prefix xsd: <http://www.w3.org/2001/XMLSchema#>  
prefix qb: <http://purl.org/linked-data/cube#>  
prefix pav: <http://purl.org/pav>  
prefix dct: <http://purl.org/dc/terms/>  
'
```

# Get data set


```r
SPARQLquery<- '
select ?dataset
where {
?dataset a qb:DataSet .
} 
'

SPARQLscript<- paste( SPARQLprefix, SPARQLquery )
result <- sparql.rdf(cube, SPARQLscript )
knitr::kable(result)
```



|dataset                           |
|:---------------------------------|
|http://example.org/ns#dataset-le3 |

# Get the data structure definition in the store


```r
SPARQLquery<- '
select ?dataset ?dsd
where {
?dataset a qb:DataSet ;
  qb:structure ?dsd .
 ?dsd a qb:DataStructureDefinition  .
} 
'

SPARQLscript<- paste( SPARQLprefix, SPARQLquery )
result <- sparql.rdf(cube, SPARQLscript )
knitr::kable(result)
```



|dataset                           |dsd                           |
|:---------------------------------|:-----------------------------|
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |

# Get the componentes in the data structure definition in the store


```r
SPARQLquery<- '
select ?dataset ?dsd ?component ?componentPropery ?componentReference 
where {
?dataset a qb:DataSet ;
  qb:structure ?dsd .
?dsd a qb:DataStructureDefinition;
qb:component ?component .
?component ?componentPropery ?componentReference .
} 
'

SPARQLscript<- paste( SPARQLprefix, SPARQLquery )
result <- sparql.rdf(cube, SPARQLscript )
knitr::kable(result)
```



|dataset                           |dsd                           |component                        |componentPropery       |componentReference                                          |
|:---------------------------------|:-----------------------------|:--------------------------------|:----------------------|:-----------------------------------------------------------|
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |6533b738d5a568e0761ea0380f083d29 |qb:order               |1                                                           |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |6533b738d5a568e0761ea0380f083d29 |qb:dimension           |http://example.org/ns#refArea                               |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |6533b738d5a568e0761ea0380f083d29 |qb:componentProperty   |http://example.org/ns#refArea                               |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |1357660f7fb3cc55769e7a2f6c539285 |qb:order               |2                                                           |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |1357660f7fb3cc55769e7a2f6c539285 |qb:dimension           |http://example.org/ns#refPeriod                             |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |1357660f7fb3cc55769e7a2f6c539285 |qb:componentProperty   |http://example.org/ns#refPeriod                             |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |1357660f7fb3cc55769e7a2f6c539285 |qb:componentAttachment |qb:Slice                                                    |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |531a16261a192fca34d222ed8e7e8f28 |qb:order               |3                                                           |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |531a16261a192fca34d222ed8e7e8f28 |qb:dimension           |http://purl.org/linked-data/sdmx/2009/dimension#sex         |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |531a16261a192fca34d222ed8e7e8f28 |qb:componentProperty   |http://purl.org/linked-data/sdmx/2009/dimension#sex         |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |531a16261a192fca34d222ed8e7e8f28 |qb:componentAttachment |qb:Slice                                                    |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |125916225cac7c189063f1056445ac91 |qb:measure             |http://example.org/ns#lifeExpectancy                        |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |125916225cac7c189063f1056445ac91 |qb:componentProperty   |http://example.org/ns#lifeExpectancy                        |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |8eb7e43387f4f503366718c89afe1a3c |qb:componentRequired   |true                                                        |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |8eb7e43387f4f503366718c89afe1a3c |qb:componentProperty   |http://purl.org/linked-data/sdmx/2009/attribute#unitMeasure |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |8eb7e43387f4f503366718c89afe1a3c |qb:componentAttachment |qb:DataSet                                                  |
|http://example.org/ns#dataset-le3 |http://example.org/ns#dsd-le3 |8eb7e43387f4f503366718c89afe1a3c |qb:attribute           |http://purl.org/linked-data/sdmx/2009/attribute#unitMeasure |

# Get the dimension, measures and attributes


```r
SPARQLquery<- '
select ?dataset ?component ?isblankcomponent ?componentProperty ?componentReference ?ordercp ?order ?label
where {
?dataset a qb:DataSet ;
  qb:structure ?dsd .
?dsd a qb:DataStructureDefinition;
qb:component ?component .
?component ?componentProperty ?componentReference .
optional{ ?component qb:order ?temporder . }
BIND( ISBLANK(?component) as ?isblankcomponent )
optional{ ?componentReference rdfs:label ?templabel . }
BIND(
if( ?componentProperty = qb:dimension, 1001, 
   if( ?componentProperty = qb:measure, 2001,
      if( ?componentProperty = qb:attribute, 3001, 9001 )
        )
  )
 as ?ordercp )
BIND( COALESCE( ?temporder, 0 )  as ?order )
BIND( COALESCE( ?templabel, "" )  as ?label )
values ( ?componentProperty ) {
(qb:attribute)
(qb:dimension)
(qb:measure)
}
}
order by ?dataset ?ordercp ?order ?componentReference
'
SPARQLscript<- paste( SPARQLprefix, SPARQLquery )
result <- data.frame(sparql.rdf(cube, SPARQLscript ),stringsAsFactors=FALSE)
knitr::kable(result)
```



|dataset                           |component                        |isblankcomponent |componentProperty |componentReference                                          |ordercp |order |label            |
|:---------------------------------|:--------------------------------|:----------------|:-----------------|:-----------------------------------------------------------|:-------|:-----|:----------------|
|http://example.org/ns#dataset-le3 |6533b738d5a568e0761ea0380f083d29 |true             |qb:dimension      |http://example.org/ns#refArea                               |1001    |1     |reference area   |
|http://example.org/ns#dataset-le3 |1357660f7fb3cc55769e7a2f6c539285 |true             |qb:dimension      |http://example.org/ns#refPeriod                             |1001    |2     |reference period |
|http://example.org/ns#dataset-le3 |531a16261a192fca34d222ed8e7e8f28 |true             |qb:dimension      |http://purl.org/linked-data/sdmx/2009/dimension#sex         |1001    |3     |                 |
|http://example.org/ns#dataset-le3 |125916225cac7c189063f1056445ac91 |true             |qb:measure        |http://example.org/ns#lifeExpectancy                        |2001    |0     |life expectancy  |
|http://example.org/ns#dataset-le3 |8eb7e43387f4f503366718c89afe1a3c |true             |qb:attribute      |http://purl.org/linked-data/sdmx/2009/attribute#unitMeasure |3001    |0     |                 |

Add CONSTRUCT query that defines the cube from the SPARQL results above.

# Make SPARQL query for getting observations for example.ttl

This will not work as the cube is not normalized.



```r
genfor<- result[result$dataset==result$dataset[1],]
genfor$colnames<- sapply(strsplit(genfor$componentReference, "#"), "[", 2)

SPARQLquery<- paste( "select * where {",
      "?obs a qb:Observation;",
      "# qb:dataSet  ?dataset ; ",
      paste("",
          "<", genfor$componentReference, ">", " ", "?", genfor$colnames, " ;", sep="", collapse="\n"
      ),
      ".", 
      paste( "#values (?dataset) { (",
            "<", result$dataset[1], ">",
            ") }", sep="", collapse="\n"
            ),
      "}", sep="\n", collapse="\n"
      )

SPARQLscript<- paste( SPARQLprefix, SPARQLquery )
cat(SPARQLscript, "\n")
oresult <- data.frame(sparql.rdf(cube, SPARQLscript ),stringsAsFactors=FALSE)
knitr::kable(oresult)
```

# Make SPARQL query for getting observations for example.ttl

This query below expects the cube is normalized, which is the case for
the cube loaded in the store. Note, it will not work on the example
cube as presented in RDF Data Cube Vocabulary, as the example cube is
by purpose not normalised.



```r
genfor<- result[result$dataset==result$dataset[1],]
genfor$colnames<- sapply(strsplit(genfor$componentReference, "#"), "[", 2)

SPARQLquery<- paste( "select * where {",
      "?obs a qb:Observation;",
      "qb:dataSet  ?dataset ; ",
      paste(
          "<", genfor$componentReference, ">", " ", "?", genfor$colnames, " ;", sep="", collapse="\n"
      ),
      ".", 
      paste( "values (?dataset) { (",
            "<", result$dataset[1], ">",
            ") }", sep="", collapse="\n"
            ),
      "}", sep="\n", collapse="\n"
      )

SPARQLscript<- paste( SPARQLprefix, SPARQLquery )
cat(SPARQLscript, "\n")
```


prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>  
prefix skos: <http://www.w3.org/2004/02/skos/core#>  
prefix prov: <http://www.w3.org/ns/prov#>  
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>  
prefix dcat: <http://www.w3.org/ns/dcat#>  
prefix owl: <http://www.w3.org/2002/07/owl#>  
prefix xsd: <http://www.w3.org/2001/XMLSchema#>  
prefix qb: <http://purl.org/linked-data/cube#>  
prefix pav: <http://purl.org/pav>  
prefix dct: <http://purl.org/dc/terms/>  
 select * where {
?obs a qb:Observation;
qb:dataSet  ?dataset ; 
<http://example.org/ns#refArea> ?refArea ;
<http://example.org/ns#refPeriod> ?refPeriod ;
<http://purl.org/linked-data/sdmx/2009/dimension#sex> ?sex ;
<http://example.org/ns#lifeExpectancy> ?lifeExpectancy ;
<http://purl.org/linked-data/sdmx/2009/attribute#unitMeasure> ?unitMeasure ;
.
values (?dataset) { (<http://example.org/ns#dataset-le3>) }
} 

```r
oresult <- data.frame(sparql.rdf(cube, SPARQLscript ),stringsAsFactors=FALSE)
knitr::kable(oresult)
```



|obs                       |dataset                           |refArea                                   |refPeriod                                                                  |sex                                              |lifeExpectancy |unitMeasure                      |
|:-------------------------|:---------------------------------|:-----------------------------------------|:--------------------------------------------------------------------------|:------------------------------------------------|:--------------|:--------------------------------|
|http://example.org/ns#o61 |http://example.org/ns#dataset-le3 |http://example.org/geo#newport_00pr       |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |81.5           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o12 |http://example.org/ns#dataset-le3 |http://example.org/geo#cardiff_00pt       |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |78.7           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o42 |http://example.org/ns#dataset-le3 |http://example.org/geo#cardiff_00pt       |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |83.7           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o63 |http://example.org/ns#dataset-le3 |http://example.org/geo#monmouthshire_00pp |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |81.7           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o22 |http://example.org/ns#dataset-le3 |http://example.org/geo#cardiff_00pt       |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |83.3           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o24 |http://example.org/ns#dataset-le3 |http://example.org/geo#merthyr_tdfil_00ph |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |79.1           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o33 |http://example.org/ns#dataset-le3 |http://example.org/geo#monmouthshire_00pp |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |76.5           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o54 |http://example.org/ns#dataset-le3 |http://example.org/geo#merthyr_tdfil_00ph |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |74.9           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o41 |http://example.org/ns#dataset-le3 |http://example.org/geo#newport_00pr       |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |80.9           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o21 |http://example.org/ns#dataset-le3 |http://example.org/geo#newport_00pr       |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |80.7           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o51 |http://example.org/ns#dataset-le3 |http://example.org/geo#newport_00pr       |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |77.0           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o53 |http://example.org/ns#dataset-le3 |http://example.org/geo#monmouthshire_00pp |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |76.6           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o23 |http://example.org/ns#dataset-le3 |http://example.org/geo#monmouthshire_00pp |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |81.3           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o32 |http://example.org/ns#dataset-le3 |http://example.org/geo#cardiff_00pt       |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |78.6           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o34 |http://example.org/ns#dataset-le3 |http://example.org/geo#merthyr_tdfil_00ph |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |75.5           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o44 |http://example.org/ns#dataset-le3 |http://example.org/geo#merthyr_tdfil_00ph |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |79.4           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o14 |http://example.org/ns#dataset-le3 |http://example.org/geo#merthyr_tdfil_00ph |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |75.5           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o31 |http://example.org/ns#dataset-le3 |http://example.org/geo#newport_00pr       |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |77.1           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o52 |http://example.org/ns#dataset-le3 |http://example.org/geo#cardiff_00pt       |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |78.7           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o11 |http://example.org/ns#dataset-le3 |http://example.org/geo#newport_00pr       |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |76.7           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o62 |http://example.org/ns#dataset-le3 |http://example.org/geo#cardiff_00pt       |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |83.4           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o13 |http://example.org/ns#dataset-le3 |http://example.org/geo#monmouthshire_00pp |http://reference.data.gov.uk/id/gregorian-interval/2004-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-M |76.6           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o64 |http://example.org/ns#dataset-le3 |http://example.org/geo#merthyr_tdfil_00ph |http://reference.data.gov.uk/id/gregorian-interval/2006-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |79.6           |http://dbpedia.org/resource/Year |
|http://example.org/ns#o43 |http://example.org/ns#dataset-le3 |http://example.org/geo#monmouthshire_00pp |http://reference.data.gov.uk/id/gregorian-interval/2005-01-01T00:00:00/P3Y |http://purl.org/linked-data/sdmx/2009/code#sex-F |81.5           |http://dbpedia.org/resource/Year |
