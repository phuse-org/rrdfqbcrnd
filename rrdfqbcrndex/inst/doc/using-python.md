Using Python with SPARQL scripts for the demographics cube (DC-DEMO-sample.ttl)
===============================================================================

The examples below uses `rdflib` from (<https://github.com/RDFLib/rdflib>).

As of 28-jun-2015 the code is still in development.

Requirement
-----------

The python package `rdflib` must be installed, see description at (<https://github.com/RDFLib/rdflib>).

Get dimensions
--------------

``` python
from rdflib import Graph
g = Graph()
g.parse("../extdata/sample-rdf/DC-DEMO-sample.ttl", format="turtle")
with open ("../extdata/sample-rdf/DEMOdimensions.rq", "r") as myfile:
    dimensionsQuery=myfile.read()
qres = g.query(dimensionsQuery)
for row in qres:
    print("%s" %row)
```

    ## INFO:rdflib:RDFLib Version: 4.2.0
    ## http://www.example.org/dc/dimension#factor
    ## http://www.example.org/dc/dimension#race
    ## http://www.example.org/dc/dimension#agegr1
    ## http://www.example.org/dc/dimension#sex
    ## http://www.example.org/dc/dimension#ethnic
    ## http://www.example.org/dc/dimension#procedure
    ## http://www.example.org/dc/dimension#trt01a

Get attributes
--------------

``` python
from rdflib import Graph
g = Graph()
g.parse("../extdata/sample-rdf/DC-DEMO-sample.ttl", format="turtle")
with open ("../extdata/sample-rdf/DEMOattributes.rq", "r") as myfile:
    attributesQuery=myfile.read()
qres = g.query(attributesQuery)
for row in qres:
    print("%s" %row)
```

    ## INFO:rdflib:RDFLib Version: 4.2.0
    ## http://www.example.org/dc/attribute#rowno
    ## http://www.example.org/dc/attribute#unit
    ## http://www.example.org/dc/attribute#cellpartno
    ## http://www.example.org/dc/attribute#measurefmt
    ## http://www.example.org/dc/attribute#denominator
    ## http://www.example.org/dc/attribute#colno

Get observations
----------------

The SPARQL script shows for each observation the dimension, attributes and measures in a row. The python code shows each variable on a line - that is not the right way to do it.

``` python
from rdflib import Graph
g = Graph()
g.parse("../extdata/sample-rdf/DC-DEMO-sample.ttl", format="turtle")
with open ("../extdata/sample-rdf/DEMOobservations.rq", "r") as myfile:
    observationsQuery=myfile.read()

qres = g.query(observationsQuery)

for row in qres:
   for t in row:
     print("%s" %t)
 
```

    ## INFO:rdflib:RDFLib Version: 4.2.0
    ## 
    ## _NONMISS_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 1
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs001
    ## 1
    ## http://www.example.org/dc/code/sex-_NONMISS_
    ## NA
    ## quantity
    ## 86.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _NONMISS_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 1
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs002
    ## 1
    ## http://www.example.org/dc/code/sex-_NONMISS_
    ## NA
    ## quantity
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _NONMISS_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 1
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs003
    ## 1
    ## http://www.example.org/dc/code/sex-_NONMISS_
    ## NA
    ## quantity
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## sex
    ## _NONMISS_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 1
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs004
    ## 2
    ## http://www.example.org/dc/code/sex-_NONMISS_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## sex
    ## _NONMISS_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 1
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs005
    ## 2
    ## http://www.example.org/dc/code/sex-_NONMISS_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## sex
    ## _NONMISS_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 1
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs006
    ## 2
    ## http://www.example.org/dc/code/sex-_NONMISS_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## F
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 2
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs007
    ## 1
    ## http://www.example.org/dc/code/sex-F
    ## NA
    ## quantity
    ## 53.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## F
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 2
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs008
    ## 1
    ## http://www.example.org/dc/code/sex-F
    ## NA
    ## quantity
    ## 50.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## F
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 2
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs009
    ## 1
    ## http://www.example.org/dc/code/sex-F
    ## NA
    ## quantity
    ## 40.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## sex
    ## F
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 2
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs010
    ## 2
    ## http://www.example.org/dc/code/sex-F
    ## NA
    ## proportion
    ## 61.627906977
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## sex
    ## F
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 2
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs011
    ## 2
    ## http://www.example.org/dc/code/sex-F
    ## NA
    ## proportion
    ## 59.523809524
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## sex
    ## F
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 2
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs012
    ## 2
    ## http://www.example.org/dc/code/sex-F
    ## NA
    ## proportion
    ## 47.619047619
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## M
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 3
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs013
    ## 1
    ## http://www.example.org/dc/code/sex-M
    ## NA
    ## quantity
    ## 33.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## M
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 3
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs014
    ## 1
    ## http://www.example.org/dc/code/sex-M
    ## NA
    ## quantity
    ## 34.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## M
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 3
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs015
    ## 1
    ## http://www.example.org/dc/code/sex-M
    ## NA
    ## quantity
    ## 44.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## sex
    ## M
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 3
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs016
    ## 2
    ## http://www.example.org/dc/code/sex-M
    ## NA
    ## proportion
    ## 38.372093023
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## sex
    ## M
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 3
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs017
    ## 2
    ## http://www.example.org/dc/code/sex-M
    ## NA
    ## proportion
    ## 40.476190476
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## sex
    ## M
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 3
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs018
    ## 2
    ## http://www.example.org/dc/code/sex-M
    ## NA
    ## proportion
    ## 52.380952381
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 4
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-std
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs019
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 8.5901671271
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## std
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 4
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-std
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs020
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 8.2860505995
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## std
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 4
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-std
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs021
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 7.8860938487
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## std
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 5
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-n
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs022
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 86.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## n
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 5
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-n
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs023
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## n
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 5
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-n
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs024
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## n
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 6
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-median
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs025
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 76.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## median
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 6
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-median
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs026
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 77.5
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## median
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 6
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-median
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs027
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 76.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## median
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 7
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-mean
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs028
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 75.209302326
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## mean
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 7
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-mean
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs029
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 75.666666667
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## mean
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 7
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-mean
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs030
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 74.380952381
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## mean
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 8
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-q3
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs031
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 82.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## q3
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 8
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-q3
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs032
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 82.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## q3
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 8
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-q3
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs033
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 80.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## q3
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 9
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-q1
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs034
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 69.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## q1
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 9
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-q1
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs035
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 71.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## q1
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 9
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-q1
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs036
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 70.5
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## q1
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 10
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-max
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs037
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 89.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## max
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 10
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-max
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs038
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 88.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## max
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 10
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-max
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs039
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 88.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## max
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 11
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-min
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs040
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 52.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## min
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 11
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-min
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs041
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 51.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## min
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 11
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-min
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs042
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## age
    ## 56.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## min
    ## _ALL_
    ## http://www.example.org/dc/code/factor-age
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_NONMISS_
    ## 18
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _NONMISS_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs043
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 86.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_NONMISS_
    ## 18
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _NONMISS_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs044
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_NONMISS_
    ## 18
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _NONMISS_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs045
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_NONMISS_
    ## 18
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _NONMISS_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs046
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_NONMISS_
    ## 18
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _NONMISS_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs047
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_NONMISS_
    ## 18
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _NONMISS_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs048
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_65
    ## 19
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## <65
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs049
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 14.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_65
    ## 19
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## <65
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs050
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 8.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_65
    ## 19
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## <65
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs051
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 11.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_65
    ## 19
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## <65
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs052
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 16.279069767
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_65
    ## 19
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## <65
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs053
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 9.5238095238
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_65
    ## 19
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## <65
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs054
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 13.095238095
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-65-80
    ## 20
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## 65-80
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs055
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 42.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-65-80
    ## 20
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## 65-80
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs056
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 47.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-65-80
    ## 20
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## 65-80
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs057
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 55.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-65-80
    ## 20
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## 65-80
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs058
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 48.837209302
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-65-80
    ## 20
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## 65-80
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs059
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 55.952380952
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-65-80
    ## 20
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## 65-80
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs060
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 65.476190476
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_80
    ## 21
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## >80
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs061
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 30.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_80
    ## 21
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## >80
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs062
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 29.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_80
    ## 21
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## >80
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs063
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 18.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_80
    ## 21
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## >80
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs064
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 34.88372093
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_80
    ## 21
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## >80
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs065
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 34.523809524
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## agegr1
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_80
    ## 21
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## >80
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs066
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 21.428571429
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 22
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs067
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 86.0
    ## _NONMISS_
    ## http://www.example.org/dc/code/race-_NONMISS_
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 22
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs068
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 84.0
    ## _NONMISS_
    ## http://www.example.org/dc/code/race-_NONMISS_
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 22
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs069
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 84.0
    ## _NONMISS_
    ## http://www.example.org/dc/code/race-_NONMISS_
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 22
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs070
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _NONMISS_
    ## http://www.example.org/dc/code/race-_NONMISS_
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 22
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs071
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _NONMISS_
    ## http://www.example.org/dc/code/race-_NONMISS_
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 22
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs072
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _NONMISS_
    ## http://www.example.org/dc/code/race-_NONMISS_
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 23
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs073
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 78.0
    ## WHITE
    ## http://www.example.org/dc/code/race-WHITE
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 23
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs074
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 78.0
    ## WHITE
    ## http://www.example.org/dc/code/race-WHITE
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 23
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs075
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 74.0
    ## WHITE
    ## http://www.example.org/dc/code/race-WHITE
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 23
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs076
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 90.697674419
    ## WHITE
    ## http://www.example.org/dc/code/race-WHITE
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 23
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs077
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 92.857142857
    ## WHITE
    ## http://www.example.org/dc/code/race-WHITE
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 23
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs078
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 88.095238095
    ## WHITE
    ## http://www.example.org/dc/code/race-WHITE
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 24
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs079
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 8.0
    ## BLACK OR AFRICAN AMERICAN
    ## http://www.example.org/dc/code/race-BLACK_OR_AFRICAN_AMERICAN
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 24
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs080
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 6.0
    ## BLACK OR AFRICAN AMERICAN
    ## http://www.example.org/dc/code/race-BLACK_OR_AFRICAN_AMERICAN
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 24
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs081
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 9.0
    ## BLACK OR AFRICAN AMERICAN
    ## http://www.example.org/dc/code/race-BLACK_OR_AFRICAN_AMERICAN
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 24
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs082
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 9.3023255814
    ## BLACK OR AFRICAN AMERICAN
    ## http://www.example.org/dc/code/race-BLACK_OR_AFRICAN_AMERICAN
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 24
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs083
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 7.1428571429
    ## BLACK OR AFRICAN AMERICAN
    ## http://www.example.org/dc/code/race-BLACK_OR_AFRICAN_AMERICAN
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 24
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs084
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 10.714285714
    ## BLACK OR AFRICAN AMERICAN
    ## http://www.example.org/dc/code/race-BLACK_OR_AFRICAN_AMERICAN
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 25
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs085
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 0.0
    ## AMERICAN INDIAN OR ALASKA NATIVE
    ## http://www.example.org/dc/code/race-AMERICAN_INDIAN_OR_ALASKA_NATIVE
    ## Placebo
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 25
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs086
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 0.0
    ## AMERICAN INDIAN OR ALASKA NATIVE
    ## http://www.example.org/dc/code/race-AMERICAN_INDIAN_OR_ALASKA_NATIVE
    ## Xanomeline Low Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 25
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs087
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 1.0
    ## AMERICAN INDIAN OR ALASKA NATIVE
    ## http://www.example.org/dc/code/race-AMERICAN_INDIAN_OR_ALASKA_NATIVE
    ## Xanomeline High Dose
    ## count
    ## _ALL_
    ## http://www.example.org/dc/code/factor-quantity
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 25
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs088
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 0.0
    ## AMERICAN INDIAN OR ALASKA NATIVE
    ## http://www.example.org/dc/code/race-AMERICAN_INDIAN_OR_ALASKA_NATIVE
    ## Placebo
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 25
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs089
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 0.0
    ## AMERICAN INDIAN OR ALASKA NATIVE
    ## http://www.example.org/dc/code/race-AMERICAN_INDIAN_OR_ALASKA_NATIVE
    ## Xanomeline Low Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## race
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 25
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs090
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 1.1904761905
    ## AMERICAN INDIAN OR ALASKA NATIVE
    ## http://www.example.org/dc/code/race-AMERICAN_INDIAN_OR_ALASKA_NATIVE
    ## Xanomeline High Dose
    ## percent
    ## _ALL_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 26
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-std
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs091
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 12.771543533
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## std
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 26
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-std
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs092
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 14.123598649
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## std
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 26
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-std
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs093
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 14.653433372
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## std
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 27
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-n
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs094
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 86.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## n
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 27
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-n
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs095
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 83.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## n
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 27
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-n
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs096
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## n
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 28
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-median
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs097
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 60.55
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## median
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 28
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-median
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs098
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 64.9
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## median
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 28
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-median
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs099
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 69.2
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## median
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 29
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-mean
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs100
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 62.759302326
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## mean
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 29
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-mean
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs101
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 67.279518072
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## mean
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 29
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-mean
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs102
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 70.004761905
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## mean
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 30
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-q3
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs103
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 74.4
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## q3
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 30
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-q3
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs104
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 77.8
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## q3
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 30
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-q3
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs105
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 80.3
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## q3
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 31
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-q1
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs106
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 53.5
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## q1
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 31
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-q1
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs107
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 55.8
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## q1
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 31
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-q1
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs108
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 56.75
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## q1
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 32
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-max
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs109
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 86.2
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## max
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 32
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-max
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs110
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 106.1
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## max
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 32
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-max
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs111
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 108.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## max
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 33
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-min
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs112
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 34.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## min
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 33
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-min
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs113
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 45.4
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## min
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 33
    ## http://www.example.org/dc/code/ethnic-_ALL_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-min
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs114
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## weightbl
    ## 41.7
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## min
    ## _ALL_
    ## http://www.example.org/dc/code/factor-weightbl
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 36
    ## http://www.example.org/dc/code/ethnic-_NONMISS_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs115
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 86.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## _NONMISS_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 36
    ## http://www.example.org/dc/code/ethnic-_NONMISS_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs116
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## _NONMISS_
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 36
    ## http://www.example.org/dc/code/ethnic-_NONMISS_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs117
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 84.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## _NONMISS_
    ## http://www.example.org/dc/code/factor-quantity
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 36
    ## http://www.example.org/dc/code/ethnic-_NONMISS_
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs118
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## _NONMISS_
    ## http://www.example.org/dc/code/factor-proportion
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 36
    ## http://www.example.org/dc/code/ethnic-_NONMISS_
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs119
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## _NONMISS_
    ## http://www.example.org/dc/code/factor-proportion
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 36
    ## http://www.example.org/dc/code/ethnic-_NONMISS_
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs120
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 100.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## _NONMISS_
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 38
    ## http://www.example.org/dc/code/ethnic-NOT_HISPANIC_OR_LATINO
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs121
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 83.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## NOT HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 38
    ## http://www.example.org/dc/code/ethnic-NOT_HISPANIC_OR_LATINO
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs122
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 78.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## NOT HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 38
    ## http://www.example.org/dc/code/ethnic-NOT_HISPANIC_OR_LATINO
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs123
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 81.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## NOT HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-quantity
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 38
    ## http://www.example.org/dc/code/ethnic-NOT_HISPANIC_OR_LATINO
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs124
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 96.511627907
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## NOT HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-proportion
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 38
    ## http://www.example.org/dc/code/ethnic-NOT_HISPANIC_OR_LATINO
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs125
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 92.857142857
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## NOT HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-proportion
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 38
    ## http://www.example.org/dc/code/ethnic-NOT_HISPANIC_OR_LATINO
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs126
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 96.428571429
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## NOT HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-proportion
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 40
    ## http://www.example.org/dc/code/ethnic-HISPANIC_OR_LATINO
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs127
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 3.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## count
    ## HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 40
    ## http://www.example.org/dc/code/ethnic-HISPANIC_OR_LATINO
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs128
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 6.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## count
    ## HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-quantity
    ## 
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 40
    ## http://www.example.org/dc/code/ethnic-HISPANIC_OR_LATINO
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-count
    ## _ALL_
    ## %6.0f
    ## http://www.example.org/dc/demo/ds/obs129
    ## 1
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## quantity
    ## 3.0
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## count
    ## HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-quantity
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 40
    ## http://www.example.org/dc/code/ethnic-HISPANIC_OR_LATINO
    ## 1
    ## http://www.example.org/dc/code/trt01a-Placebo
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs130
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 3.488372093
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Placebo
    ## percent
    ## HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-proportion
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 40
    ## http://www.example.org/dc/code/ethnic-HISPANIC_OR_LATINO
    ## 2
    ## http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs131
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 7.1428571429
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline Low Dose
    ## percent
    ## HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-proportion
    ## ethnic
    ## _ALL_
    ## http://www.example.org/dc/code/agegr1-_ALL_
    ## 40
    ## http://www.example.org/dc/code/ethnic-HISPANIC_OR_LATINO
    ## 3
    ## http://www.example.org/dc/code/trt01a-Xanomeline_High_Dose
    ## http://www.example.org/dc/code/procedure-percent
    ## _ALL_
    ## %6.1f
    ## http://www.example.org/dc/demo/ds/obs132
    ## 2
    ## http://www.example.org/dc/code/sex-_ALL_
    ## NA
    ## proportion
    ## 3.5714285714
    ## _ALL_
    ## http://www.example.org/dc/code/race-_ALL_
    ## Xanomeline High Dose
    ## percent
    ## HISPANIC OR LATINO
    ## http://www.example.org/dc/code/factor-proportion

Get definition for all descriptive statistics
---------------------------------------------

The SPARQL script shows how the function definition for the descriptive statistics is stored in the cube.

``` python
from rdflib import Graph
g = Graph()
g.parse("../extdata/sample-rdf/DC-DEMO-sample.ttl", format="turtle")
with open ("../extdata/sample-rdf/DEMOprocedure.rq", "r") as myfile:
    procedureQuery=myfile.read()
qres = g.query(procedureQuery)
for row in qres:
     print("%s| %s| %s" %row)
```

    ## INFO:rdflib:RDFLib Version: 4.2.0
    ## http://www.example.org/dc/code/procedure-n| n| function (x)  {     length(x[!is.na(x)]) }
    ## http://www.example.org/dc/code/procedure-median| median| function (x)  {     median(x, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-min| min| function (x)  {     min(x, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-percent| percent| function (x)  {     -1 }
    ## http://www.example.org/dc/code/procedure-mean| mean| function (x)  {     mean(x, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-q1| q1| function (x)  {     quantile(x, probs = c(0.25), type = 2, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-std| std| function (x)  {     sd(x, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-count| count| function (x)  {     length(x) }
    ## http://www.example.org/dc/code/procedure-max| max| function (x)  {     max(x, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-q3| q3| function (x)  {     quantile(x, probs = c(0.75), type = 2, na.rm = TRUE) }

Get definition for descriptive statistics median
------------------------------------------------

The SPARQL script shows how the function definition for the descriptive statistics is stored in the cube.

``` python
from rdflib import Graph
g = Graph()
g.parse("../extdata/sample-rdf/DC-DEMO-sample.ttl", format="turtle")
with open ("../extdata/sample-rdf/DEMOprocedure-median.rq", "r") as myfile:
    proceduremedianQuery=myfile.read()
qres = g.query(proceduremedianQuery)
for row in qres:
     print("%s| %s| %s" %row)
```

    ## INFO:rdflib:RDFLib Version: 4.2.0
    ## http://www.example.org/dc/code/procedure-median| http://www.w3.org/2004/02/skos/core#inScheme| http://www.example.org/dc/code/procedure
    ## http://www.example.org/dc/code/procedure-median| http://www.w3.org/1999/02/22-rdf-syntax-ns#type| http://www.w3.org/2004/02/skos/core#Concept
    ## http://www.example.org/dc/code/procedure-median| http://www.w3.org/2000/01/rdf-schema#comment| Descriptive statistics median
    ## http://www.example.org/dc/code/procedure-median| http://www.example.org/rrdfqbcrnd0/R-selectionvalue| median
    ## http://www.example.org/dc/code/procedure-median| http://www.example.org/rrdfqbcrnd0/R-selectionoperator| ==
    ## http://www.example.org/dc/code/procedure-median| http://www.w3.org/1999/02/22-rdf-syntax-ns#type| http://www.example.org/dc/code/Procedure
    ## http://www.example.org/dc/code/procedure-median| http://www.w3.org/2004/02/skos/core#prefLabel| median
    ## http://www.example.org/dc/code/procedure-median| http://www.example.org/rrdfqbcrnd0/RdescStatDefFun| function (x)  {     median(x, na.rm = TRUE) }
    ## http://www.example.org/dc/code/procedure-median| http://www.w3.org/2004/02/skos/core#topConceptOf| http://www.example.org/dc/code/procedure

Get information for selection of data
-------------------------------------

The SPARQL script shows how the information for selecting data for derivation of univariate statistics is present in the cube.

``` python
from rdflib import Graph
g = Graph()
g.parse("../extdata/sample-rdf/DC-DEMO-sample.ttl", format="turtle")
with open ("../extdata/sample-rdf/DEMOobservations-R-selection.rq", "r") as myfile:
    observationsRselection=myfile.read()
qres = g.query(observationsRselection)
for row in qres:
     print("%s| %s| %s| %s" %row)
```

    ## INFO:rdflib:RDFLib Version: 4.2.0
    ## http://www.example.org/dc/demo/ds/obs056| agegr1| ==| 65-80
    ## http://www.example.org/dc/demo/ds/obs027| trt01a| ==| Xanomeline High Dose
    ## http://www.example.org/dc/demo/ds/obs056| trt01a| ==| Xanomeline Low Dose
