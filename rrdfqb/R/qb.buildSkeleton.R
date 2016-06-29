##' Create RDF data cube skeleton from 
##'
##' The skeletonSource is expected to contain compType corresponding to the compoents in
##' an RDF data cube: dimension, measure and attribute.
##' Consider: shorten code by introducing variables for properties etc. MJA 16-11-2014
##' @inheritParams qb.buildDSD
##' @return always TRUE
##' @author Tim Williams, Marc Andersen
##' @export qb.buildSkeleton
qb.buildSkeleton<- function(store, prefixlist,obsData, skeletonSource) {
## Loop through to create Property and Component specs

for (i in 1:nrow(skeletonSource)){
   component <- tolower(skeletonSource[i,"compType"])
   ##DEBUG message ("Component:", component)
  ##------------------  Dimensions ---------------------------------------------
  if (component == "dimension"){
    ## Class name is the compName with an uppercase first letter.
    compNameClass <- capitalize(toString(skeletonSource[i,"compName"]))
    ##DEBUG message ("Building: Dimension")
    add.triple(store,
               paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "DimensionProperty"))

    add.triple(store,
               paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "CodedProperty"))
      
    add.triple(store,
               paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixRDF, "Property"))

    ## Label for property. Example:   rdfs:label "Treatment Arm"@en .
    add.data.triple(store,
                    paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]),
                    "http://www.w3.org/2000/01/rdf-schema#label",
                    paste0(skeletonSource[i,"compLabel"]))

      add.triple(store,
                 paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]),
                 paste0(prefixlist$prefixQB, "codeList"),
                paste0(prefixlist$prefixCODE,skeletonSource[i,"compName"]))

      add.triple(store,
                      paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]),
                      "http://www.w3.org/2000/01/rdf-schema#range",
                      paste0(prefixlist$prefixCODE,compNameClass))

    ## qb:ComponentSpecification

    add.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "ComponentSpecification"))
    add.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixQB, "dimension"),
               paste0(prefixlist$`prefixCRND-DIMENSION`, skeletonSource[i,"compName"]))

    add.data.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               "http://www.w3.org/2000/01/rdf-schema#label",
               paste0(skeletonSource[i,"compLabel"]))
  }
  ##------------------  Measure ------------------------------------------------
  else if (component =="measure"){

    add.triple(store,
               paste0(prefixlist$`prefixCRND-MEASURE`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "MeasureProperty"))

    add.triple(store,
               paste0(prefixlist$`prefixCRND-MEASURE`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixRDF, "Property"))

    ## Label for property
    add.data.triple(store,
                    paste0(prefixlist$`prefixCRND-MEASURE`, skeletonSource[i,"compName"]),
                    "http://www.w3.org/2000/01/rdf-schema#label",
                    paste0(skeletonSource[i,"compLabel"]))
    ## ComponentSpecification
    add.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "ComponentSpecification"))

    add.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixQB, "measure"),
               paste0(prefixlist$`prefixCRND-MEASURE`, skeletonSource[i,"compName"]))

    add.data.triple(store,
                    paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
                    "http://www.w3.org/2000/01/rdf-schema#label",
                    paste0(skeletonSource[i,"compLabel"]))
  }
  #------------------ Attributes ----------------------------------------------
  else if (component == "attribute"){
    ##DEBUG message ("Building: Attribute")
    ## Property
    add.triple(store,
               paste0(prefixlist$`prefixCRND-ATTRIBUTE`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "AttributeProperty") )
    add.triple(store,
               paste0(prefixlist$`prefixCRND-ATTRIBUTE`, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixRDF, "Property"))
    ## Label for property
    add.data.triple(store,
                    paste0(prefixlist$`prefixCRND-ATTRIBUTE`, skeletonSource[i,"compName"]),
                    "http://www.w3.org/2000/01/rdf-schema#label",
                    paste0(skeletonSource[i,"compLabel"]))
    ## ComponentSpecification
    add.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixQB, "ComponentSpecification"))
    add.triple(store,
               paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]),
               paste0(prefixlist$prefixQB, "attribute"),
               paste0(prefixlist$`prefixCRND-ATTRIBUTE`, skeletonSource[i,"compName"]))
    }else{
      message ("***ERROR: Undefined Component Type in compType column. Check source file")
  }
}# End looping through each component

invisible(TRUE)
}
