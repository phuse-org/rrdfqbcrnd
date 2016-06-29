---
title: "SQL code for verifying results in RDF data cube"
author: "mja@statgroup.dk"
date: "2016-06-29"
vignette: >
  %\VignetteIndexEntry{SQL code for verifying results in RDF data cube}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
---

# Derive results in RDF data cube and compare with results in data cube

## Setup
Here all libraries are loaded; this should not be necessary.

```r
options(width=200) # long lines
library(xlsx)
```

```
## Loading required package: rJava
```

```
## Loading required package: methods
```

```
## Loading required package: xlsxjars
```

```r
library(foreign)
library(rrdf)
```

```
## Loading required package: rrdflibs
```

```r
library(rrdfqb)
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
library(rrdfqbcrnd0)
```

```
## Loading required package: rrdfcdisc
```

```
## Loading required package: devtools
```

```r
library(rrdfqbcrndex)
library(rrdfqbcrndcheck)
```

## Load the data
The SAS dataset is loaded, and factors converted to character.

```r
obsFile<- system.file("extdata/sample-xpt", "adsl.xpt", package="rrdfqbcrndex")
adsl<-read.xport(obsFile)
ii <- sapply(adsl, is.factor)
adsl[ii] <- lapply(adsl[ii], as.character)
```

The conversion to character can be avoided by using
`library(SASxport)`, see
(../../rrdfqbcrndex/inst/data-raw/create-dm-table-as-csv.Rmd).

## Load the RDF data cube
The RDF data cube is loaded.

```r
dataCubeFile<- system.file("extdata/sample-rdf", "DC-DEMO-sample.ttl", package="rrdfqbcrndex")
store <- new.rdf()  # Initialize
cat("Reading turtle definition from ", dataCubeFile, "\n")
```

```
## Reading turtle definition from  /home/ma/R/x86_64-redhat-linux-gnu-library/3.3/rrdfqbcrndex/extdata/sample-rdf/DC-DEMO-sample.ttl
```

```r
temp<- load.rdf(dataCubeFile, format="TURTLE", appendTo= store)
summarize.rdf(store)
```

```
## [1] "Number of triples: 3095"
```

With a SPARQL query the mean values for the `WEIGHTBL` variable in RDF data cube the are extracted.

```r
rq<-'
prefix crnd-measure: <http://www.example.org/dc/measure#> 
prefix code:  <http://www.example.org/dc/code/> 
prefix crnd-attribute: <http://www.example.org/dc/attribute#> 
prefix ds:    <http://www.example.org/dc/demo/ds/> 
prefix qb:    <http://purl.org/linked-data/cube#> 
prefix crnd-dimension: <http://www.example.org/dc/dimension#> 
select * where {
?obs  a                         qb:Observation ;
    qb:dataSet                  ds:dataset-DEMO ;
        crnd-dimension:agegr1       code:agegr1-_ALL_ ;
        crnd-dimension:ethnic       code:ethnic-_ALL_ ;
        crnd-dimension:factor       code:factor-weightbl ;
        crnd-dimension:procedure    code:procedure-mean ;
        crnd-dimension:race         code:race-_ALL_ ;
        crnd-dimension:sex          code:sex-_ALL_ ;
        crnd-dimension:trt01a       ?trt01a ;
    crnd-measure:measure        ?measure .
}
'
knitr::kable(data.frame(sparql.rdf( store, rq)))
```



|obs       |trt01a                           |measure      |
|:---------|:--------------------------------|:------------|
|ds:obs100 |code:trt01a-Placebo              |62.759302326 |
|ds:obs102 |code:trt01a-Xanomeline_High_Dose |70.004761905 |
|ds:obs101 |code:trt01a-Xanomeline_Low_Dose  |67.279518072 |

The SPARQL query about can be made more generic. 

## Generate SQL statements
From the RDF data cube loading in the store, the function `GetSQLFromCube` generates the SQL statements for reproducing the data cube.
Only the first two select statements are shown.


```r
stmtSQL<- GetSQLFromCube( store, srcDsName="adsl" )
cat(paste(unlist(strsplit(stmtSQL$summStatSQL,split="\n"))[1:3],collapse="\n"),"\n")
```

```
## SELECT '_ALL_' as ETHNIC, '_ALL_' as RACE, '_ALL_' as AGEGR1, a.TRT01A, '_ALL_' as SEX, 'count' as procedure, 'quantity' as factor, '' as denominator, 'NA' as unit, CAST( count(*) AS REAL) as measure from  adsl  as a   group by  a.TRT01A
## UNION
## SELECT '_ALL_' as ETHNIC, '_ALL_' as RACE, '_ALL_' as AGEGR1, a.TRT01A, '_ALL_' as SEX, 'percent' as procedure, 'proportion' as factor, 'sex' as denominator, 'NA' as unit, 100*avg(a.SEX=b.SEX) as measure from  adsl  as a , (select distinct SEX from adsl) as b group by  a.TRT01A
```

## Derive the descriptive statistics

To show the full SQL expression use


```r
cat(stmtSQL$summStatSQL)
```


```r
library(sqldf)
```

```
## Loading required package: gsubfn
```

```
## Loading required package: proto
```

```
## Loading required package: RSQLite
```

```
## Loading required package: DBI
```

```r
adsl.summ.stat.res<- sqldf( stmtSQL$summStatSQL)
```

```
## Loading required package: tcltk
```

```r
names(adsl.summ.stat.res)<- tolower(gsub("(a|b)\\.","", names(adsl.summ.stat.res)))
knitr::kable(adsl.summ.stat.res)
```



|ethnic                 |race                             |agegr1 |trt01a               |sex   |procedure |factor     |denominator |unit |   measure|
|:----------------------|:--------------------------------|:------|:--------------------|:-----|:---------|:----------|:-----------|:----|---------:|
|HISPANIC OR LATINO     |_ALL_                            |_ALL_  |Placebo              |_ALL_ |count     |quantity   |            |NA   |  3.000000|
|HISPANIC OR LATINO     |_ALL_                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |ethnic      |NA   |  3.488372|
|HISPANIC OR LATINO     |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   |  3.000000|
|HISPANIC OR LATINO     |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |ethnic      |NA   |  3.571429|
|HISPANIC OR LATINO     |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   |  6.000000|
|HISPANIC OR LATINO     |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |ethnic      |NA   |  7.142857|
|NOT HISPANIC OR LATINO |_ALL_                            |_ALL_  |Placebo              |_ALL_ |count     |quantity   |            |NA   | 83.000000|
|NOT HISPANIC OR LATINO |_ALL_                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |ethnic      |NA   | 96.511628|
|NOT HISPANIC OR LATINO |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   | 81.000000|
|NOT HISPANIC OR LATINO |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |ethnic      |NA   | 96.428571|
|NOT HISPANIC OR LATINO |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   | 78.000000|
|NOT HISPANIC OR LATINO |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |ethnic      |NA   | 92.857143|
|_ALL_                  |AMERICAN INDIAN OR ALASKA NATIVE |_ALL_  |Placebo              |_ALL_ |percent   |proportion |race        |NA   |  0.000000|
|_ALL_                  |AMERICAN INDIAN OR ALASKA NATIVE |_ALL_  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   |  1.000000|
|_ALL_                  |AMERICAN INDIAN OR ALASKA NATIVE |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |race        |NA   |  1.190476|
|_ALL_                  |AMERICAN INDIAN OR ALASKA NATIVE |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |race        |NA   |  0.000000|
|_ALL_                  |BLACK OR AFRICAN AMERICAN        |_ALL_  |Placebo              |_ALL_ |count     |quantity   |            |NA   |  8.000000|
|_ALL_                  |BLACK OR AFRICAN AMERICAN        |_ALL_  |Placebo              |_ALL_ |percent   |proportion |race        |NA   |  9.302326|
|_ALL_                  |BLACK OR AFRICAN AMERICAN        |_ALL_  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   |  9.000000|
|_ALL_                  |BLACK OR AFRICAN AMERICAN        |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |race        |NA   | 10.714286|
|_ALL_                  |BLACK OR AFRICAN AMERICAN        |_ALL_  |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   |  6.000000|
|_ALL_                  |BLACK OR AFRICAN AMERICAN        |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |race        |NA   |  7.142857|
|_ALL_                  |WHITE                            |_ALL_  |Placebo              |_ALL_ |count     |quantity   |            |NA   | 78.000000|
|_ALL_                  |WHITE                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |race        |NA   | 90.697674|
|_ALL_                  |WHITE                            |_ALL_  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   | 74.000000|
|_ALL_                  |WHITE                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |race        |NA   | 88.095238|
|_ALL_                  |WHITE                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   | 78.000000|
|_ALL_                  |WHITE                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |race        |NA   | 92.857143|
|_ALL_                  |_ALL_                            |65-80  |Placebo              |_ALL_ |count     |quantity   |            |NA   | 42.000000|
|_ALL_                  |_ALL_                            |65-80  |Placebo              |_ALL_ |percent   |proportion |agegr1      |NA   | 48.837209|
|_ALL_                  |_ALL_                            |65-80  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   | 55.000000|
|_ALL_                  |_ALL_                            |65-80  |Xanomeline High Dose |_ALL_ |percent   |proportion |agegr1      |NA   | 65.476191|
|_ALL_                  |_ALL_                            |65-80  |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   | 47.000000|
|_ALL_                  |_ALL_                            |65-80  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |agegr1      |NA   | 55.952381|
|_ALL_                  |_ALL_                            |<65    |Placebo              |_ALL_ |count     |quantity   |            |NA   | 14.000000|
|_ALL_                  |_ALL_                            |<65    |Placebo              |_ALL_ |percent   |proportion |agegr1      |NA   | 16.279070|
|_ALL_                  |_ALL_                            |<65    |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   | 11.000000|
|_ALL_                  |_ALL_                            |<65    |Xanomeline High Dose |_ALL_ |percent   |proportion |agegr1      |NA   | 13.095238|
|_ALL_                  |_ALL_                            |<65    |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   |  8.000000|
|_ALL_                  |_ALL_                            |<65    |Xanomeline Low Dose  |_ALL_ |percent   |proportion |agegr1      |NA   |  9.523810|
|_ALL_                  |_ALL_                            |>80    |Placebo              |_ALL_ |count     |quantity   |            |NA   | 30.000000|
|_ALL_                  |_ALL_                            |>80    |Placebo              |_ALL_ |percent   |proportion |agegr1      |NA   | 34.883721|
|_ALL_                  |_ALL_                            |>80    |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   | 18.000000|
|_ALL_                  |_ALL_                            |>80    |Xanomeline High Dose |_ALL_ |percent   |proportion |agegr1      |NA   | 21.428571|
|_ALL_                  |_ALL_                            |>80    |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   | 29.000000|
|_ALL_                  |_ALL_                            |>80    |Xanomeline Low Dose  |_ALL_ |percent   |proportion |agegr1      |NA   | 34.523809|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |F     |count     |quantity   |            |NA   | 53.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |F     |percent   |proportion |sex         |NA   | 61.627907|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |M     |count     |quantity   |            |NA   | 33.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |M     |percent   |proportion |sex         |NA   | 38.372093|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |count     |quantity   |            |NA   | 86.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |max       |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |max       |weightbl   |            |NA   | 74.400000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |mean      |age        |            |NA   | 75.209302|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |mean      |weightbl   |            |NA   | 62.759302|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |median    |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |median    |weightbl   |            |NA   | 74.400000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |min       |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |min       |weightbl   |            |NA   | 74.400000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |n         |age        |            |NA   | 86.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |n         |weightbl   |            |NA   | 86.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |agegr1      |NA   | 33.333333|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |ethnic      |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |race        |NA   | 33.333333|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |percent   |proportion |sex         |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |q1        |age        |            |NA   | 69.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |q1        |weightbl   |            |NA   | 53.500000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |q3        |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |q3        |weightbl   |            |NA   | 74.400000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |std       |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Placebo              |_ALL_ |std       |weightbl   |            |NA   | 74.400000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |F     |count     |quantity   |            |NA   | 40.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |F     |percent   |proportion |sex         |NA   | 47.619048|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |M     |count     |quantity   |            |NA   | 44.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |M     |percent   |proportion |sex         |NA   | 52.380952|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |count     |quantity   |            |NA   | 84.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |max       |age        |            |NA   | 80.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |max       |weightbl   |            |NA   | 80.300000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |mean      |age        |            |NA   | 74.380952|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |mean      |weightbl   |            |NA   | 70.004762|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |median    |age        |            |NA   | 80.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |median    |weightbl   |            |NA   | 80.300000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |min       |age        |            |NA   | 80.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |min       |weightbl   |            |NA   | 80.300000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |n         |age        |            |NA   | 84.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |n         |weightbl   |            |NA   | 84.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |agegr1      |NA   | 33.333333|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |ethnic      |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |race        |NA   | 33.333333|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |percent   |proportion |sex         |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |q1        |age        |            |NA   | 70.500000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |q1        |weightbl   |            |NA   | 56.750000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |q3        |age        |            |NA   | 80.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |q3        |weightbl   |            |NA   | 80.300000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |std       |age        |            |NA   | 80.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline High Dose |_ALL_ |std       |weightbl   |            |NA   | 80.300000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |F     |count     |quantity   |            |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |F     |percent   |proportion |sex         |NA   | 59.523809|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |M     |count     |quantity   |            |NA   | 34.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |M     |percent   |proportion |sex         |NA   | 40.476191|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |count     |quantity   |            |NA   | 84.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |max       |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |max       |weightbl   |            |NA   | 77.800000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |mean      |age        |            |NA   | 75.666667|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |mean      |weightbl   |            |NA   | 67.279518|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |median    |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |median    |weightbl   |            |NA   | 77.800000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |min       |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |min       |weightbl   |            |NA   | 77.800000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |n         |age        |            |NA   | 84.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |n         |weightbl   |            |NA   | 84.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |agegr1      |NA   | 33.333333|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |ethnic      |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |race        |NA   | 33.333333|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |percent   |proportion |sex         |NA   | 50.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |q1        |age        |            |NA   | 71.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |q1        |weightbl   |            |NA   | 55.800000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |q3        |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |q3        |weightbl   |            |NA   | 77.800000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |std       |age        |            |NA   | 82.000000|
|_ALL_                  |_ALL_                            |_ALL_  |Xanomeline Low Dose  |_ALL_ |std       |weightbl   |            |NA   | 77.800000|

## Quick check
Sometimes it is usefull to see that there is an actual derivation going on.
The calculated mean values for the `WEIGHTBL` variable is

```r
knitr::kable(adsl.summ.stat.res[adsl.summ.stat.res$factor=="WEIGHTBL" & adsl.summ.stat.res$procedure=="mean",])
```



|ethnic |race |agegr1 |trt01a |sex |procedure |factor |denominator |unit | measure|
|:------|:----|:------|:------|:---|:---------|:------|:-----------|:----|-------:|

If `WEIGHTBL` is multiplied by 100, then mean should also be multiplied with 100:

```r
adsl$WEIGHTBL<- adsl$WEIGHTBL*100
adsl.summ.stat.mod.res<- sqldf( stmtSQL$summStatSQL)
knitr::kable(adsl.summ.stat.mod.res[adsl.summ.stat.mod.res$factor=="WEIGHTBL" & adsl.summ.stat.mod.res$procedure=="mean",])
```



|ETHNIC |RACE |AGEGR1 |a.TRT01A |SEX |procedure |factor |denominator |unit | measure|
|:------|:----|:------|:--------|:---|:---------|:------|:-----------|:----|-------:|
