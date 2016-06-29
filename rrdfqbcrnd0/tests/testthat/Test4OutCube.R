library(knitr)
library(rrdf)

library(testthat)

library (xlsx)
library(SASxport)
library(plyr)

context("Test for DC-DM-sample.TTL file")

# Prepare test data
# generate RDFCube of Demographics from ADSL dataset from ./vignettes/dm-table-from-csv.Rmd
rmdFilePath <- paste0(getwd(), "/vignettes/dm-table-from-csv.Rmd")
rFileTempPath <- paste0(tempdir(), "dm-table-from-csv.R")
purl(input = rmdFilePath, output = rFileTempPath)
source(rFileTempPath)
file.remove(rFileTempPath)
resultCube.ttl <- load.rdf(outcube, "TURTLE")

# ADSL datafile form PhUSE Scriptathon repogitory
adsl_xpt <- read.xport("http://phuse-scripts.googlecode.com/svn/trunk/scriptathon2014/data/adsl.xpt", as.is = TRUE)


test_that("check Count value of SEX", {
    spql.query = "SELECT * WHERE {?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#Observation>;
                                 <http://www.example.org/dc/DM/prop/trt01a> ?TRT01A;
                                 <http://www.example.org/dc/DM/prop/sex> ?SEX;
                                 <http://www.example.org/dc/DM/prop/race> ?RACE;
                                 <http://www.example.org/dc/DM/prop/procedure> ?PROCEDURE;
                                 <http://www.example.org/dc/DM/prop/measure> ?measure.
                                 FILTER (?TRT01A = <http://www.example.org/dc/code/trt01a-Placebo> &&
                                         ?SEX = <http://www.example.org/dc/code/sex-F> &&
                                         ?RACE = <http://www.example.org/dc/code/race-_ALL_> &&
                                         ?PROCEDURE = <http://www.example.org/dc/code/procedure-COUNT>)

                                 } order by ?TRT01A ?SEX ?RACE"

  cube_Placebo_F_N <-sparql.rdf(resultCube.ttl, spql.query)

  sex_n <- ddply(adsl_xpt, .(SAFFL, TRT01A, SEX), summarize, N = length(SEX))
  xpt_Placebo_F_N <- sex_n[sex_n$TRT01A == "Placebo" & sex_n$SEX == "F",]

  cube_val <- as.numeric(cube_Placebo_F_N[,"measure"])
  xpt_val <- as.numeric(xpt_Placebo_F_N$N)

  expect_equal(cube_val, xpt_val)
})
