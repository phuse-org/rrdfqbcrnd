Introduction
============

This is a somewhat convoluted script. The idea is to take an existing cube structure and derive the results. That was usefull initially to extend a cube. Now, it is not as usefull. So the script may seem pointless. TODO(mja): fix it.

Create DM sample table as CSV file and other files
==================================================

This script creates the result and codelist for a simple DM table.

``` r
library(rrdfancillary)
devtools::load_all(pkg="../..")
```

    ## Loading rrdfqbcrndex

Get the data and prepare for derivation of summary statistics
-------------------------------------------------------------

``` r
library(foreign)
library(sqldf)


fnadsl<- system.file("extdata/sample-xpt", "adsl.xpt", package="rrdfqbcrndex")
print(fnadsl)
```

    ## [1] "/home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-xpt/adsl.xpt"

``` r
if (!file.exists(fnadsl)) {
  fnadsl<- file.path("..", "extdata/sample-xpt", "adsl.xpt")
  }
if (!file.exists(fnadsl)) {
  stop("File does not exist - ",fnadsl)
}
adsl<- read.xport(fnadsl)
adsl$TRT01A<- as.character(adsl$TRT01A)
adsl$RACE<- as.character(adsl$RACE)
adsl$SAFFL<- as.character(adsl$SAFFL)
adsl$SEX<- as.character(adsl$SEX)

## SASxport package maps characters and dates etc into more R like data type
## install.packages("SASxport")
## library(SASxport)
## adsl<- as.data.frame(read.xport(fnadsl,as.is=TRUE))
## str(adsl)
```

Create frame for cube from an existing RDF data cube
----------------------------------------------------

The code input a turtle file with an RDF data cube. SQL statements for calculating the measurements are derived from the cube, and used to derive the summary statistics. Note: the SQL statements does not show records where the combination of values lead to 0 observations. This is handled below, in a not so clever way. A better approach would be to include the concept of a skeleton in the SQL statements.

ToDo(MJA): move this to rrdfqbcrndcheck or move to another package, like rrdfqcbcrnd0

``` r
library(rrdfqbcrndcheck)

dataCubeFile<- system.file("extdata/sample-rdf", "DC-DM-sample.ttl", package="rrdfqbcrndex")
checkCube <- new.rdf(ontology=FALSE)  # Initialize
load.rdf(dataCubeFile, format="TURTLE", appendTo= checkCube)
summarize.rdf(checkCube)

stmtSQL<- GetSQLFromCube(checkCube) 

cat(stmtSQL$summStatSQL) 

adsl.summ.stat.res<- sqldf( stmtSQL$summStatSQL)
names(adsl.summ.stat.res)<- tolower(gsub("(a|b)\\.","", names(adsl.summ.stat.res)))
```

Store the SQL statements to a file
----------------------------------

``` r
res.text<- stmtSQL$summStatSQL

cr.text<-   paste0("create table qbframe ", "(", paste(names(stmtSQL$qbframe), "TEXT", collapse=", "), ")",";")

in.text<-   paste0(
  paste(
  paste0("insert into qbframe ", "(", paste0(names(stmtSQL$qbframe),collapse=","), ")\n" ),
  "values\n",
  paste0( "(", apply(stmtSQL$qbframe,1,function(x) {paste0('"',x,'"', collapse=",")}), ")",  collapse=",\n"),
  collapse="\n"
  ),";\n")

se.text<- "select * from qbframe;"

tempfile<- file.path(tempdir(),"temp-code.R")
cat(paste('res.text<- "', res.text,'"\n',collapse="\n"), file=tempfile)
cat(paste("cr.text<- '", cr.text,"'\n",collapse="\n"), file=tempfile,append=TRUE)
cat(paste("in.text<- '", in.text,"'\n",collapse="\n"), file=tempfile,append=TRUE)
cat(paste("se.text<- '", se.text,"'\n",collapse="\n"), file=tempfile,append=TRUE)
print(tempfile)
```

Define SQL statements directly
------------------------------

The statements below are inserted from the file generated above.

Work-around: add SELECT statments below corresponding to the desired statistics. Update the .csv file, and re-create the cube. Repeat until done. This is of course not the ideal way; waiting to the formular interface to the cube.

Note: the `GetSQLFromCube` functions in package `rrdfqbcrndcheck` generates the SQL statements from the cube obversvations.

``` r
res.text<- "
SELECT a.TRT01A, '_ALL_' as RACE, a.SEX, a.SAFFL, 'count' as procedure, 'quantity' as factor, '_ALL_' as denominator, '_NULL_' as unit, count(*) as measure from  adsl  as a   group by  a.TRT01A, a.SEX, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'mean' as procedure, 'WEIGHTBL' as factor, '_NULL_' as denominator, 'KG' as unit, avg(WEIGHTBL) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'max' as procedure, 'WEIGHTBL' as factor, '_NULL_' as denominator, 'KG' as unit, max(WEIGHTBL) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'max' as procedure, 'AGE' as factor, '_NULL_' as denominator, 'YEARS' as unit, max(AGE) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'median' as procedure, 'WEIGHTBL' as factor, '_NULL_' as denominator, 'KG' as unit, median(WEIGHTBL) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, a.RACE, '_ALL_' as SEX, a.SAFFL, 'count' as procedure, 'quantity' as factor, '_ALL_' as denominator, '_NULL_' as unit, count(*) as measure from  adsl  as a   group by  a.TRT01A, a.RACE, a.SAFFL
UNION
SELECT a.TRT01A, b.RACE, '_ALL_' as SEX, a.SAFFL, 'percent' as procedure, 'proportion' as factor, 'RACE' as denominator, '_NULL_' as unit, 100*avg(a.RACE=b.RACE) as measure from  adsl  as a , (select distinct RACE from adsl) as b group by  a.TRT01A, b.RACE, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'stdev' as procedure, 'AGE' as factor, '_NULL_' as denominator, 'YEARS' as unit, stdev(AGE) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'min' as procedure, 'AGE' as factor, '_NULL_' as denominator, 'YEARS' as unit, min(AGE) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, b.SEX, a.SAFFL, 'percent' as procedure, 'proportion' as factor, 'SEX' as denominator, '_NULL_' as unit, 100*avg(a.SEX=b.SEX) as measure from  adsl  as a , (select distinct SEX from adsl) as b group by  a.TRT01A, b.SEX, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'min' as procedure, 'WEIGHTBL' as factor, '_NULL_' as denominator, 'KG' as unit, min(WEIGHTBL) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT '_ALL_' as TRT01A, a.RACE, '_ALL_' as SEX, a.SAFFL, 'count' as procedure, 'quantity' as factor, '_ALL_' as denominator, '_NULL_' as unit, count(*) as measure from  adsl  as a   group by  a.RACE, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'mean' as procedure, 'AGE' as factor, '_NULL_' as denominator, 'YEARS' as unit, avg(AGE) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT '_ALL_' as TRT01A, '_ALL_' as RACE, a.SEX, a.SAFFL, 'count' as procedure, 'quantity' as factor, '_ALL_' as denominator, '_NULL_' as unit, count(*) as measure from  adsl  as a   group by  a.SEX, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'median' as procedure, 'AGE' as factor, '_NULL_' as denominator, 'YEARS' as unit, median(AGE) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'count' as procedure, 'quantity' as factor, '_ALL_' as denominator, '_NULL_' as unit, count(*) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
UNION
SELECT a.TRT01A, '_ALL_' as RACE, '_ALL_' as SEX, a.SAFFL, 'stdev' as procedure, 'WEIGHTBL' as factor, '_NULL_' as denominator, 'KG' as unit, stdev(WEIGHTBL) as measure from  adsl  as a   group by  a.TRT01A, a.SAFFL
"


cr.text<- '
create table qbframe (trt01a TEXT, race TEXT, factor TEXT, procedure TEXT, sex TEXT, saffl TEXT, unit TEXT, denominator TEXT);
'

in.text<- '
insert into qbframe (trt01a,race,factor,procedure,sex,saffl,unit,denominator)
 values
("Xanomeline High Dose","AMERICAN INDIAN OR ALASKA NATIVE","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Xanomeline Low Dose","AMERICAN INDIAN OR ALASKA NATIVE","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Xanomeline Low Dose","BLACK OR AFRICAN AMERICAN","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Placebo","_ALL_","quantity","count","F","Y","_NULL_","_ALL_"),
("_ALL_","WHITE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","_ALL_","AGE","min","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","_ALL_","AGE","stdev","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline Low Dose","_ALL_","proportion","percent","M","Y","_NULL_","SEX"),
("Placebo","_ALL_","AGE","stdev","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","WHITE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","WHITE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline High Dose","_ALL_","AGE","max","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","AMERICAN INDIAN OR ALASKA NATIVE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Placebo","BLACK OR AFRICAN AMERICAN","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Placebo","_ALL_","AGE","max","_ALL_","Y","YEARS","_NULL_"),
("Placebo","AMERICAN INDIAN OR ALASKA NATIVE","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Placebo","BLACK OR AFRICAN AMERICAN","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Xanomeline Low Dose","_ALL_","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Placebo","_ALL_","quantity","count","M","Y","_NULL_","_ALL_"),
("Placebo","_ALL_","proportion","percent","F","Y","_NULL_","SEX"),
("Xanomeline High Dose","_ALL_","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","_ALL_","quantity","count","M","Y","_NULL_","_ALL_"),
("Xanomeline High Dose","_ALL_","proportion","percent","F","Y","_NULL_","SEX"),
("Xanomeline Low Dose","_ALL_","quantity","count","F","Y","_NULL_","_ALL_"),
("Placebo","_ALL_","AGE","mean","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","_ALL_","AGE","median","_ALL_","Y","YEARS","_NULL_"),
("Placebo","_ALL_","AGE","min","_ALL_","Y","YEARS","_NULL_"),
("_ALL_","BLACK OR AFRICAN AMERICAN","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Placebo","_ALL_","AGE","median","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline Low Dose","_ALL_","AGE","stdev","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline Low Dose","AMERICAN INDIAN OR ALASKA NATIVE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","BLACK OR AFRICAN AMERICAN","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","_ALL_","AGE","max","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","BLACK OR AFRICAN AMERICAN","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Xanomeline High Dose","WHITE","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Xanomeline Low Dose","WHITE","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("_ALL_","_ALL_","quantity","count","M","Y","_NULL_","_ALL_"),
("Xanomeline High Dose","_ALL_","quantity","count","M","Y","_NULL_","_ALL_"),
("_ALL_","_ALL_","quantity","count","F","Y","_NULL_","_ALL_"),
("Xanomeline High Dose","_ALL_","quantity","count","F","Y","_NULL_","_ALL_"),
("Placebo","_ALL_","proportion","percent","M","Y","_NULL_","SEX"),
("Xanomeline Low Dose","_ALL_","proportion","percent","F","Y","_NULL_","SEX"),
("Xanomeline Low Dose","_ALL_","AGE","mean","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","_ALL_","proportion","percent","M","Y","_NULL_","SEX"),
("Placebo","AMERICAN INDIAN OR ALASKA NATIVE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline High Dose","_ALL_","AGE","mean","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","BLACK OR AFRICAN AMERICAN","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Placebo","WHITE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","_ALL_","AGE","median","_ALL_","Y","YEARS","_NULL_"),
("Xanomeline High Dose","_ALL_","AGE","min","_ALL_","Y","YEARS","_NULL_"),
("_ALL_","AMERICAN INDIAN OR ALASKA NATIVE","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Placebo","WHITE","proportion","percent","_ALL_","Y","_NULL_","RACE"),
("Placebo","_ALL_","quantity","count","_ALL_","Y","_NULL_","_ALL_"),
("Xanomeline Low Dose","_ALL_","WEIGHTBL","min","_ALL_","Y","KG","_NULL_"),
("Xanomeline High Dose","_ALL_","WEIGHTBL","stdev","_ALL_","Y","KG","_NULL_"),
("Placebo","_ALL_","WEIGHTBL","stdev","_ALL_","Y","KG","_NULL_"),
("Xanomeline High Dose","_ALL_","WEIGHTBL","max","_ALL_","Y","KG","_NULL_"),
("Placebo","_ALL_","WEIGHTBL","max","_ALL_","Y","KG","_NULL_"),
("Placebo","_ALL_","WEIGHTBL","mean","_ALL_","Y","KG","_NULL_"),
("Xanomeline High Dose","_ALL_","WEIGHTBL","median","_ALL_","Y","KG","_NULL_"),
("Placebo","_ALL_","WEIGHTBL","min","_ALL_","Y","KG","_NULL_"),
("Placebo","_ALL_","WEIGHTBL","median","_ALL_","Y","KG","_NULL_"),
("Xanomeline Low Dose","_ALL_","WEIGHTBL","stdev","_ALL_","Y","KG","_NULL_"),
("Xanomeline Low Dose","_ALL_","WEIGHTBL","max","_ALL_","Y","KG","_NULL_"),
("Xanomeline Low Dose","_ALL_","WEIGHTBL","mean","_ALL_","Y","KG","_NULL_"),
("Xanomeline High Dose","_ALL_","WEIGHTBL","mean","_ALL_","Y","KG","_NULL_"),
("Xanomeline Low Dose","_ALL_","WEIGHTBL","median","_ALL_","Y","KG","_NULL_"),
("Xanomeline High Dose","_ALL_","WEIGHTBL","min","_ALL_","Y","KG","_NULL_")
;
'
se.text<-'
select * from qbframe;
'
```

### Evaluate the SQL code

``` r
adsl.summ.stat.res<- sqldf( res.text )
# adsl.summ.stat$unit<- "_NULL_"
names(adsl.summ.stat.res)<- tolower(gsub("(a|b)\\.","", names(adsl.summ.stat.res)))

rm(qbframe)
sqldf()
```

    ## <SQLiteConnection>

``` r
sqldf(cr.text )
```

    ## NULL

``` r
sqldf(in.text  )
```

    ## NULL

``` r
qbframe<- sqldf(se.text)
sqldf()
```

    ## NULL

``` r
# str(qbframe)
```

### Combine generated results with the cube frame and write CSV file

``` r
adsl.summ.stat<- merge(qbframe,adsl.summ.stat.res,by=names(qbframe),all=TRUE)
# adsl.summ.stat<- merge(stmtSQL$qbframe,adsl.summ.stat.res,all=TRUE)
adsl.summ.stat$measure[ is.na(adsl.summ.stat$measure) & adsl.summ.stat$procedure=="count" ]<- 0
adsl.summ.stat
```

    ##                  trt01a                             race     factor
    ## 1                 _ALL_                            _ALL_   quantity
    ## 2                 _ALL_                            _ALL_   quantity
    ## 3                 _ALL_ AMERICAN INDIAN OR ALASKA NATIVE   quantity
    ## 4                 _ALL_        BLACK OR AFRICAN AMERICAN   quantity
    ## 5                 _ALL_                            WHITE   quantity
    ## 6               Placebo                            _ALL_        AGE
    ## 7               Placebo                            _ALL_        AGE
    ## 8               Placebo                            _ALL_        AGE
    ## 9               Placebo                            _ALL_        AGE
    ## 10              Placebo                            _ALL_        AGE
    ## 11              Placebo                            _ALL_ proportion
    ## 12              Placebo                            _ALL_ proportion
    ## 13              Placebo                            _ALL_   quantity
    ## 14              Placebo                            _ALL_   quantity
    ## 15              Placebo                            _ALL_   quantity
    ## 16              Placebo                            _ALL_   WEIGHTBL
    ## 17              Placebo                            _ALL_   WEIGHTBL
    ## 18              Placebo                            _ALL_   WEIGHTBL
    ## 19              Placebo                            _ALL_   WEIGHTBL
    ## 20              Placebo                            _ALL_   WEIGHTBL
    ## 21              Placebo AMERICAN INDIAN OR ALASKA NATIVE proportion
    ## 22              Placebo AMERICAN INDIAN OR ALASKA NATIVE   quantity
    ## 23              Placebo        BLACK OR AFRICAN AMERICAN proportion
    ## 24              Placebo        BLACK OR AFRICAN AMERICAN   quantity
    ## 25              Placebo                            WHITE proportion
    ## 26              Placebo                            WHITE   quantity
    ## 27 Xanomeline High Dose                            _ALL_        AGE
    ## 28 Xanomeline High Dose                            _ALL_        AGE
    ## 29 Xanomeline High Dose                            _ALL_        AGE
    ## 30 Xanomeline High Dose                            _ALL_        AGE
    ## 31 Xanomeline High Dose                            _ALL_        AGE
    ## 32 Xanomeline High Dose                            _ALL_ proportion
    ## 33 Xanomeline High Dose                            _ALL_ proportion
    ## 34 Xanomeline High Dose                            _ALL_   quantity
    ## 35 Xanomeline High Dose                            _ALL_   quantity
    ## 36 Xanomeline High Dose                            _ALL_   quantity
    ## 37 Xanomeline High Dose                            _ALL_   WEIGHTBL
    ## 38 Xanomeline High Dose                            _ALL_   WEIGHTBL
    ## 39 Xanomeline High Dose                            _ALL_   WEIGHTBL
    ## 40 Xanomeline High Dose                            _ALL_   WEIGHTBL
    ## 41 Xanomeline High Dose                            _ALL_   WEIGHTBL
    ## 42 Xanomeline High Dose AMERICAN INDIAN OR ALASKA NATIVE proportion
    ## 43 Xanomeline High Dose AMERICAN INDIAN OR ALASKA NATIVE   quantity
    ## 44 Xanomeline High Dose        BLACK OR AFRICAN AMERICAN proportion
    ## 45 Xanomeline High Dose        BLACK OR AFRICAN AMERICAN   quantity
    ## 46 Xanomeline High Dose                            WHITE proportion
    ## 47 Xanomeline High Dose                            WHITE   quantity
    ## 48  Xanomeline Low Dose                            _ALL_        AGE
    ## 49  Xanomeline Low Dose                            _ALL_        AGE
    ## 50  Xanomeline Low Dose                            _ALL_        AGE
    ## 51  Xanomeline Low Dose                            _ALL_        AGE
    ## 52  Xanomeline Low Dose                            _ALL_        AGE
    ## 53  Xanomeline Low Dose                            _ALL_ proportion
    ## 54  Xanomeline Low Dose                            _ALL_ proportion
    ## 55  Xanomeline Low Dose                            _ALL_   quantity
    ## 56  Xanomeline Low Dose                            _ALL_   quantity
    ## 57  Xanomeline Low Dose                            _ALL_   quantity
    ## 58  Xanomeline Low Dose                            _ALL_   WEIGHTBL
    ## 59  Xanomeline Low Dose                            _ALL_   WEIGHTBL
    ## 60  Xanomeline Low Dose                            _ALL_   WEIGHTBL
    ## 61  Xanomeline Low Dose                            _ALL_   WEIGHTBL
    ## 62  Xanomeline Low Dose                            _ALL_   WEIGHTBL
    ## 63  Xanomeline Low Dose AMERICAN INDIAN OR ALASKA NATIVE proportion
    ## 64  Xanomeline Low Dose AMERICAN INDIAN OR ALASKA NATIVE   quantity
    ## 65  Xanomeline Low Dose        BLACK OR AFRICAN AMERICAN proportion
    ## 66  Xanomeline Low Dose        BLACK OR AFRICAN AMERICAN   quantity
    ## 67  Xanomeline Low Dose                            WHITE proportion
    ## 68  Xanomeline Low Dose                            WHITE   quantity
    ##    procedure   sex saffl   unit denominator    measure
    ## 1      count     F     Y _NULL_       _ALL_ 143.000000
    ## 2      count     M     Y _NULL_       _ALL_ 111.000000
    ## 3      count _ALL_     Y _NULL_       _ALL_   1.000000
    ## 4      count _ALL_     Y _NULL_       _ALL_  23.000000
    ## 5      count _ALL_     Y _NULL_       _ALL_ 230.000000
    ## 6        max _ALL_     Y  YEARS      _NULL_  89.000000
    ## 7       mean _ALL_     Y  YEARS      _NULL_  75.209302
    ## 8     median _ALL_     Y  YEARS      _NULL_  76.000000
    ## 9        min _ALL_     Y  YEARS      _NULL_  52.000000
    ## 10     stdev _ALL_     Y  YEARS      _NULL_   8.590167
    ## 11   percent     F     Y _NULL_         SEX  61.627907
    ## 12   percent     M     Y _NULL_         SEX  38.372093
    ## 13     count _ALL_     Y _NULL_       _ALL_  86.000000
    ## 14     count     F     Y _NULL_       _ALL_  53.000000
    ## 15     count     M     Y _NULL_       _ALL_  33.000000
    ## 16       max _ALL_     Y     KG      _NULL_  86.200000
    ## 17      mean _ALL_     Y     KG      _NULL_  62.759302
    ## 18    median _ALL_     Y     KG      _NULL_  60.550000
    ## 19       min _ALL_     Y     KG      _NULL_  34.000000
    ## 20     stdev _ALL_     Y     KG      _NULL_  12.771544
    ## 21   percent _ALL_     Y _NULL_        RACE   0.000000
    ## 22     count _ALL_     Y _NULL_       _ALL_   0.000000
    ## 23   percent _ALL_     Y _NULL_        RACE   9.302326
    ## 24     count _ALL_     Y _NULL_       _ALL_   8.000000
    ## 25   percent _ALL_     Y _NULL_        RACE  90.697674
    ## 26     count _ALL_     Y _NULL_       _ALL_  78.000000
    ## 27       max _ALL_     Y  YEARS      _NULL_  88.000000
    ## 28      mean _ALL_     Y  YEARS      _NULL_  74.380952
    ## 29    median _ALL_     Y  YEARS      _NULL_  76.000000
    ## 30       min _ALL_     Y  YEARS      _NULL_  56.000000
    ## 31     stdev _ALL_     Y  YEARS      _NULL_   7.886094
    ## 32   percent     F     Y _NULL_         SEX  47.619048
    ## 33   percent     M     Y _NULL_         SEX  52.380952
    ## 34     count _ALL_     Y _NULL_       _ALL_  84.000000
    ## 35     count     F     Y _NULL_       _ALL_  40.000000
    ## 36     count     M     Y _NULL_       _ALL_  44.000000
    ## 37       max _ALL_     Y     KG      _NULL_ 108.000000
    ## 38      mean _ALL_     Y     KG      _NULL_  70.004762
    ## 39    median _ALL_     Y     KG      _NULL_  69.200000
    ## 40       min _ALL_     Y     KG      _NULL_  41.700000
    ## 41     stdev _ALL_     Y     KG      _NULL_  14.653433
    ## 42   percent _ALL_     Y _NULL_        RACE   1.190476
    ## 43     count _ALL_     Y _NULL_       _ALL_   1.000000
    ## 44   percent _ALL_     Y _NULL_        RACE  10.714286
    ## 45     count _ALL_     Y _NULL_       _ALL_   9.000000
    ## 46   percent _ALL_     Y _NULL_        RACE  88.095238
    ## 47     count _ALL_     Y _NULL_       _ALL_  74.000000
    ## 48       max _ALL_     Y  YEARS      _NULL_  88.000000
    ## 49      mean _ALL_     Y  YEARS      _NULL_  75.666667
    ## 50    median _ALL_     Y  YEARS      _NULL_  77.500000
    ## 51       min _ALL_     Y  YEARS      _NULL_  51.000000
    ## 52     stdev _ALL_     Y  YEARS      _NULL_   8.286051
    ## 53   percent     F     Y _NULL_         SEX  59.523810
    ## 54   percent     M     Y _NULL_         SEX  40.476190
    ## 55     count _ALL_     Y _NULL_       _ALL_  84.000000
    ## 56     count     F     Y _NULL_       _ALL_  50.000000
    ## 57     count     M     Y _NULL_       _ALL_  34.000000
    ## 58       max _ALL_     Y     KG      _NULL_ 106.100000
    ## 59      mean _ALL_     Y     KG      _NULL_  67.279518
    ## 60    median _ALL_     Y     KG      _NULL_  64.900000
    ## 61       min _ALL_     Y     KG      _NULL_  45.400000
    ## 62     stdev _ALL_     Y     KG      _NULL_  14.123599
    ## 63   percent _ALL_     Y _NULL_        RACE   0.000000
    ## 64     count _ALL_     Y _NULL_       _ALL_   0.000000
    ## 65   percent _ALL_     Y _NULL_        RACE   7.142857
    ## 66     count _ALL_     Y _NULL_       _ALL_   6.000000
    ## 67   percent _ALL_     Y _NULL_        RACE  92.857143
    ## 68     count _ALL_     Y _NULL_       _ALL_  78.000000

``` r
dmtableFile<- file.path( system.file("extdata/sample-cfg", package="rrdfqbcrndex"), "dm.AR.csv" )
## dmtableFile<- file.path(tempdir(),"temp-dm.AR.csv")

write.csv(adsl.summ.stat, file=dmtableFile, row.names=FALSE)
cat("Written to ", dmtableFile, "\n")
```

    ## Written to  /home/ma/projects/rrdfqbcrnd/rrdfqbcrndex/inst/extdata/sample-cfg/dm.AR.csv
