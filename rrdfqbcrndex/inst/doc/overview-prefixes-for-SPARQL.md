Introduction
============

This vignette provide an overview of the prefixes defined for each of the packages.

Initially the RRDFQBCRND0 packages were built with a not-so-clear understanding. Further componding to the lack of understanding is that `rrdf` function `add.triple` is an interface to Apache/Jena java function addObjectPropery. The addObjectPropery function does not turn a prefixed name into an IRI (using the terminology from [RDF 1.1 Turtle, section 2.4 IRI](https://www.w3.org/TR/turtle/#sec-iri)). This is addressed in the discussion of [Namespaces](http://jena.apache.org/documentation/rdf/#namespaces), see note at end of section

For more understanding on the use of prefixes - in other words: what I would have liked to understand some years ago - see Richard Cyganiaks post [URIs have a namespace part and a local part, right?](http://richard.cyganiak.de/blog/2016/02/uris-have-a-namespace-part-right/).

Preliminaries
-------------

First load the packages.

``` r
library(rrdfqb)
library(rrdfqbcrnd0)
devtools::load_all(pkg="../..")
```

    ## Loading rrdfqbcrndex

Prefixes in `rrdfqb`, `rrdfqbcrnd0`, `rrdfqbcrndex`
===================================================

``` r
rrdfcdisc:::env[["qbCDISCprefixes"]]
```

    ## $rdf
    ## [1] "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    ## 
    ## $skos
    ## [1] "http://www.w3.org/2004/02/skos/core#"
    ## 
    ## $prov
    ## [1] "http://www.w3.org/ns/prov#"
    ## 
    ## $rdfs
    ## [1] "http://www.w3.org/2000/01/rdf-schema#"
    ## 
    ## $dcat
    ## [1] "http://www.w3.org/ns/dcat#"
    ## 
    ## $owl
    ## [1] "http://www.w3.org/2002/07/owl#"
    ## 
    ## $xsd
    ## [1] "http://www.w3.org/2001/XMLSchema#"
    ## 
    ## $pav
    ## [1] "http://purl.org/pav"
    ## 
    ## $dc
    ## [1] "http://purl.org/dc/elements/1.1/"
    ## 
    ## $dct
    ## [1] "http://purl.org/dc/terms/"
    ## 
    ## $mms
    ## [1] "http://rdf.cdisc.org/mms#"
    ## 
    ## $cts
    ## [1] "http://rdf.cdisc.org/ct/schema#"
    ## 
    ## $cdiscs
    ## [1] "http://rdf.cdisc.org/std/schema#"
    ## 
    ## $`cdash-1-1`
    ## [1] "http://rdf.cdisc.org/std/cdash-1-1#"
    ## 
    ## $cdashct
    ## [1] "http://rdf.cdisc.org/cdash-terminology#"
    ## 
    ## $sdtmct
    ## [1] "http://rdf.cdisc.org/sdtm-terminology#"
    ## 
    ## $`sdtm-1-2`
    ## [1] "http://rdf.cdisc.org/std/sdtm-1-2#"
    ## 
    ## $`sdtm-1-3`
    ## [1] "http://rdf.cdisc.org/std/sdtm-1-3#"
    ## 
    ## $`sdtms-1-3`
    ## [1] "http://rdf.cdisc.org/sdtm-1-3/schema#"
    ## 
    ## $`sdtmig-3-1-2`
    ## [1] "http://rdf.cdisc.org/std/sdtmig-3-1-2#"
    ## 
    ## $`sdtmig-3-1-3`
    ## [1] "http://rdf.cdisc.org/std/sdtmig-3-1-3#"
    ## 
    ## $sendct
    ## [1] "http://rdf.cdisc.org/send-terminology#"
    ## 
    ## $`sendig-3-0`
    ## [1] "http://rdf.cdisc.org/std/sendig-3-0#"
    ## 
    ## $adamct
    ## [1] "http://rdf.cdisc.org/adam-terminology#"
    ## 
    ## $`adam-2-1`
    ## [1] "http://rdf.cdisc.org/std/adam-2-1#"
    ## 
    ## $`adamig-1-0`
    ## [1] "http://rdf.cdisc.org/std/adamig-1-0#"
    ## 
    ## $`adamvr-1-2`
    ## [1] "http://rdf.cdisc.org/std/adamvr-1-2#"

``` r
rrdfqb:::env[["rrdfqb"]]
```

    ## $qb
    ## [1] "http://purl.org/linked-data/cube#"

``` r
rrdfqbcrnd0:::env[["rrdfqbcrnd0"]]
```

    ## $rrdfqbcrnd0
    ## [1] "http://www.example.org/rrdfqbcrnd0/"

These prefixes are also returned by the function rrdfqbcrnd0/R/Get.default.crnd.prefixes.R

``` r
Get.default.crnd.prefixes()
```

    ## $rdf
    ## [1] "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    ## 
    ## $skos
    ## [1] "http://www.w3.org/2004/02/skos/core#"
    ## 
    ## $prov
    ## [1] "http://www.w3.org/ns/prov#"
    ## 
    ## $rdfs
    ## [1] "http://www.w3.org/2000/01/rdf-schema#"
    ## 
    ## $dcat
    ## [1] "http://www.w3.org/ns/dcat#"
    ## 
    ## $owl
    ## [1] "http://www.w3.org/2002/07/owl#"
    ## 
    ## $xsd
    ## [1] "http://www.w3.org/2001/XMLSchema#"
    ## 
    ## $pav
    ## [1] "http://purl.org/pav"
    ## 
    ## $dc
    ## [1] "http://purl.org/dc/elements/1.1/"
    ## 
    ## $dct
    ## [1] "http://purl.org/dc/terms/"
    ## 
    ## $mms
    ## [1] "http://rdf.cdisc.org/mms#"
    ## 
    ## $cts
    ## [1] "http://rdf.cdisc.org/ct/schema#"
    ## 
    ## $cdiscs
    ## [1] "http://rdf.cdisc.org/std/schema#"
    ## 
    ## $`cdash-1-1`
    ## [1] "http://rdf.cdisc.org/std/cdash-1-1#"
    ## 
    ## $cdashct
    ## [1] "http://rdf.cdisc.org/cdash-terminology#"
    ## 
    ## $sdtmct
    ## [1] "http://rdf.cdisc.org/sdtm-terminology#"
    ## 
    ## $`sdtm-1-2`
    ## [1] "http://rdf.cdisc.org/std/sdtm-1-2#"
    ## 
    ## $`sdtm-1-3`
    ## [1] "http://rdf.cdisc.org/std/sdtm-1-3#"
    ## 
    ## $`sdtms-1-3`
    ## [1] "http://rdf.cdisc.org/sdtm-1-3/schema#"
    ## 
    ## $`sdtmig-3-1-2`
    ## [1] "http://rdf.cdisc.org/std/sdtmig-3-1-2#"
    ## 
    ## $`sdtmig-3-1-3`
    ## [1] "http://rdf.cdisc.org/std/sdtmig-3-1-3#"
    ## 
    ## $sendct
    ## [1] "http://rdf.cdisc.org/send-terminology#"
    ## 
    ## $`sendig-3-0`
    ## [1] "http://rdf.cdisc.org/std/sendig-3-0#"
    ## 
    ## $adamct
    ## [1] "http://rdf.cdisc.org/adam-terminology#"
    ## 
    ## $`adam-2-1`
    ## [1] "http://rdf.cdisc.org/std/adam-2-1#"
    ## 
    ## $`adamig-1-0`
    ## [1] "http://rdf.cdisc.org/std/adamig-1-0#"
    ## 
    ## $`adamvr-1-2`
    ## [1] "http://rdf.cdisc.org/std/adamvr-1-2#"
    ## 
    ## $qb
    ## [1] "http://purl.org/linked-data/cube#"
    ## 
    ## $rrdfqbcrnd0
    ## [1] "http://www.example.org/rrdfqbcrnd0/"

The function `GetForSparqlPrefix( domainName )` returns the prefixes for use with an ARMD RDF data cube with the given domainName. Note the domain names is shown in lower case.

``` r
cat(GetForSparqlPrefix( "THE-DOMAIN-NAME" ),"\n")
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
    ## prefix dccs: <http://www.example.org/dc/the-domain-name/dccs/>
    ## prefix ds: <http://www.example.org/dc/the-domain-name/ds/>
    ## prefix crnd-dimension: <http://www.example.org/dc/dimension#>
    ## prefix crnd-attribute: <http://www.example.org/dc/attribute#>
    ## prefix crnd-measure: <http://www.example.org/dc/measure#>
    ##
