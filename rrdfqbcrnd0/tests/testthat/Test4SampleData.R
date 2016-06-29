library(testthat)
library(rrdf)

# Test for DC-DM-sample.TTL file
DCDMsample.filepath <- system.file("extdata", "sample-rdf",
                                   "DC-DM-sample.TTL",
                                   package="rrdfqbcrnd0")

DCDMsample <- load.rdf(DCDMsample.filepath, "TURTLE")
store = DCDMsample
# obs12
spql.query = "SELECT ?measure WHERE {<http://www.example.org/dc/demog/dataset/obs12>
                                     <http://www.example.org/dc/demog/prop/measure>
                                     ?measure}"
obs12.measure <- sparql.rdf(store, spql.query)

# obs56
spql.query = "SELECT ?trt01a WHERE {<http://www.example.org/dc/demog/dataset/obs56>
                                     <http://www.example.org/dc/demog/prop/trt01a>
                                     ?trt01a}"
obs56.trt01a <- sparql.rdf(store, spql.query)

test_that("check the values from DC-DM-sample.TTL file", {
  expect_equal(obs12.measure[1], "61.62790698")
  expect_equal(obs56.trt01a[1], "http://www.example.org/dc/code/trt01a-Xanomeline_Low_Dose")
})




# Test for DC-DM-sample.TTL file
DCAEsample.filepath <- system.file("extdata", "sample-rdf",
                                   "DC-AE-sample.TTL",
                                   package="rrdfqbcrnd0")

DCAEsample <- load.rdf(DCAEsample.filepath, "TURTLE")
store = DCAEsample
# obs155
spql.query = "SELECT ?measure WHERE {<http://www.example.org/dc/ae/dataset/obs155>
                                     <http://www.example.org/dc/ae/prop/measure>
                                     ?measure}"
obs155.measure <- sparql.rdf(store, spql.query)

# obs855
spql.query = "SELECT ?aesoc WHERE {<http://www.example.org/dc/ae/dataset/obs855>
                                     <http://www.example.org/dc/ae/prop/aesoc>
                                     ?aesoc}"
obs855.aesoc <- sparql.rdf(store, spql.query)

test_that("check the values from DC-AE-sample.TTL file", {
  expect_equal(obs155.measure[1], "1")
  expect_equal(obs855.aesoc[1], "http://www.example.org/dc/code/aesoc-RESPIRATORY__THORACIC_AND_MEDIASTINAL_DISORDERS")
})
