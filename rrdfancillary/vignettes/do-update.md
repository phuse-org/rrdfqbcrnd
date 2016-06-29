---
title: "SPARQL update example"
author: "mja@statgroup.dk"
date: "2016-06-29"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{SPARQL update example}
  %\VignetteEngine{knitr::rmarkdown}
  %\usepackage[utf8]{inputenc}
---


# SPARQL update example


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
library(rrdfancillary)
store <- new.rdf()
add.data.triple(store,
                subject="http://example.org/Subject",
                predicate="http://example.org/Predicate",
                data="Value")
cat(asString.rdf(store),"\n")
```

```
## @prefix owl:   <http://www.w3.org/2002/07/owl#> .
## @prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
## @prefix xsd:   <http://www.w3.org/2001/XMLSchema#> .
## @prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> .
## 
## <http://example.org/Subject>
##         <http://example.org/Predicate>  "Value" .
## 
```

```r
SPARQLinsert<- '
PREFIX dc: <http://purl.org/dc/elements/1.1/>
INSERT DATA
{ 
  <http://example/book1> dc:title "A new book" ;
                         dc:creator "A.N.Other" .
}
'

update.rdf( store, SPARQLinsert )
```

```
## [1] TRUE
```

```r
cat(asString.rdf(store), "\n")
```

```
## @prefix owl:   <http://www.w3.org/2002/07/owl#> .
## @prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
## @prefix xsd:   <http://www.w3.org/2001/XMLSchema#> .
## @prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> .
## 
## <http://example/book1>
##         <http://purl.org/dc/elements/1.1/creator>
##                 "A.N.Other" ;
##         <http://purl.org/dc/elements/1.1/title>
##                 "A new book" .
## 
## <http://example.org/Subject>
##         <http://example.org/Predicate>  "Value" .
## 
```

