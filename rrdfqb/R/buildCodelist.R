##' Add RDF data cube codelist to RDF store
##'
##' This function could be split into two function corresponding to the usage.
##' @param obsData Data Frame with the data for which the code list is to be generated
##' @param codeType Character "DATA" or "SDTM".
##' "DATA" to derive code list from the data.
##' "SDTM" to derive the code list from the rdf.cdisc.org documentation using a SPARQL query
##' @param nciDomainValue When codetype="SDTM" the nciDomain used for identifying the codelist
##' @param dimName the name of the dimension - for codeType="DATA" the name of the variable in the data frame ObsData
##' @param underlDataSetName underlying data set name. Used for finding name for D2RQ propertybridge. If NULL then not used. 
##' @param remote.endpoint Used when codetype="SDTM" to give the URL for the remote endpoint. If NULL then the local rdf.cdisc.store from the environment is used.
##' @param extension.rrdfqbcrnd0 If TRUE then rrdfqbcrnd0 specific values will be added to the generated cube
##' @return Alway TRUE - to be corrected
##' @author Tim Williams, Marc Andersen
##' @export
## TODO(mja): Move this to rrdqbcrnd0 as it uses rrdfcdisc
## TODO(mja): split function in two - one CDISC related and one for codelists from values
buildCodelist <- function(
  store,
  prefixlist,
  obsData,
  codeType,
  nciDomainValue,
  dimName,
  underlDataSetName=NULL,
  remote.endpoint=NULL,
  extension.rrdfqbcrnd0=FALSE
  ##  codelist.source
  )
{
cat("!!!!!!!!!\n")    
  dimName <- tolower(dimName)        ## dimName in all lower case is default
  capDimName <- capitalize(dimName)  ## capDim used in Class name
  ################
  ## Obtain codes #
  #############################################################################
  ## codeNoBlank - used in URI formation
  ## SDTM: cdiscSumbissionValue -> code  (the term to be coded)
  if (codeType=="DATA"){
    if (! dimName %in% names(obsData)) {
      stop( dimName, " not a column in input obsData")
    }
    codeSource <- as.data.frame(unique(obsData[,dimName])) #Unique values as dataframe
    colnames(codeSource) <- ("code")  ## Rename to match SDTM approach
  }
  else if (codeType=="SDTM"){

    query <- GetCDISCCodeListSparqlQuery( Get.rq.prefixlist.df(qbCDISCprefixes), paste0("sdtmct:", nciDomainValue ))

    if (! is.null(remote.endpoint) ) {
      codeSource <- as.data.frame(sparql.remote(remote.endpoint, query))
    } else {
      Get.env.cdiscstandards() ## the CDISC standards are cached, so the
      ## loading only happens first time the
      ## local environment is used
      ## TODO make the
      ## loading of cdiscstandards more clever
      codeSource <- as.data.frame(sparql.rdf(rrdfcdisc:::env$cdiscstandards, query))
      ## message("Result of sparql using local store")
      ## print(codeSource)
      ## print(str(codeSource))
      ## print(typeof(codeSource))
      ## print(is.data.frame(codeSource))
    }
  }
  else {
    message("ERROR: unknown codeType ", codeType, " for ", dimName )
  }
  
    ##  codeSource[,"codeNoBlank"]<- toupper(gsub(" ","_",codeSource[,"code"]))
  

  for (i in 1:nrow(codeSource)) {
#     message( i, ": ", codeSource[i,"code"] )
    codeSource[i,"codeNoBlank"]<- encodetouri( as.character(codeSource[i,"code"]))
  }

    
#############################################################################
  ## SKELETON
  ## --------- Class ---------
  add.triple(store,
             paste0(prefixlist$prefixCODE, capDimName),
             paste0(prefixlist$prefixRDF,"type" ),
             paste0(prefixlist$prefixOWL, "Class"))
  add.triple(store,
             paste0(prefixlist$prefixCODE, capDimName),
             paste0(prefixlist$prefixRDF,"type" ),
             paste0(prefixlist$prefixRDFS, "Class"))
  add.triple(store,
             paste0(prefixlist$prefixCODE, capDimName),
             paste0(prefixlist$prefixRDFS, "subClassOf"),
             paste0(prefixlist$prefixSKOS, "Concept"))
  ## Cross reference between the Class (capDimName) and the codelist (dimName)
  add.triple(store,
             paste0(prefixlist$prefixCODE, capDimName),
             paste0(prefixlist$prefixRDFS, "seeAlso"),
             paste0(prefixlist$prefixCODE, dimName))
  add.triple(store,
             paste0(prefixlist$prefixCODE, dimName),
             paste0(prefixlist$prefixRDFS, "seeAlso"),
             paste0(prefixlist$prefixCODE, capDimName))

    add.data.triple(store,
                  paste0(prefixlist$prefixCODE, capDimName),
                  paste0(prefixlist$prefixRDFS,"label"),
                  paste0("Class for code list: ", dimName),
                  lang="en")
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE, capDimName),
                  paste0(prefixlist$prefixRDFS,"comment"),
                  paste0("Specifies the ", dimName, " for each observation"),
                  lang="en")

  ## --------- ConceptScheme ---------
  add.triple(store,
             paste0(prefixlist$prefixCODE,dimName),
             paste0(prefixlist$prefixRDF,"type" ),
             paste0(prefixlist$prefixSKOS, "ConceptScheme"))
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixSKOS,"prefLabel"),
                  paste0("Codelist scheme: ", dimName),
                  lang="en")
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixRDFS,"label"),
                  paste0("Codelist scheme: ", dimName),
                  lang="en")
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixSKOS,"note"),
                  paste0("Specifies the ", dimName, " for each observation, group of obs. or all categories (_ALL_)label "),
                  lang="en")
  ## skos:notation is uppercase by convention. Eg: CL_SEX, CL_RACE
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixSKOS,"notation"),
                  paste0("CL_",toupper(dimName)))

  
  ## Add rrdfqbcrnd0 information
        if (extension.rrdfqbcrnd0) {
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixRRDFQBCRND0, "codeType"),
                  paste0(codeType),
                  type="string"
                  )
  ## Should only be added if R data set is available
  add.data.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixRRDFQBCRND0, "R-columnname"),
                  paste0(dimName),
                  type="string"
                  )
        }
    ## Should only be added if data available in D2RQ format
    ## ToDo(mja): the stem for the URI for the property is hard coded - this should be changed to use a prefix
    ## ToDo(mja): The derivation of property name should be more integrated with D2RQ
    if (!is.null(underlDataSetName) & dimName!="procedure" & dimName!="factor") {
        datasetname.subject<- paste0(prefixlist$prefixRRDFQBCRND0,toupper(underlDataSetName),"_", toupper(dimName))
        if (extension.rrdfqbcrnd0) {
        add.triple(store,
                  paste0(prefixlist$prefixCODE,dimName),
                  paste0(prefixlist$prefixRRDFQBCRND0, "DataSetRefD2RQ"),
                  datasetname.subject
                  )
        add.triple(store,
                  datasetname.subject,
                  paste0(prefixlist$prefixRRDFQBCRND0, "D2RQ-PropertyBridge"),
                  paste0("http://www.example.org/datasets/vocab/", toupper(underlDataSetName), "_", toupper(dimName))
                  )
        add.data.triple(store,
                  datasetname.subject,
                  paste0(prefixlist$prefixRRDFQBCRND0, "D2RQ-DataSetName"),
                  toupper(underlDataSetName),
                  type="string"
                  )
        }
    }

  if (codeType=="SDTM"){
    add.data.triple(store,
                    paste0(prefixlist$prefixCODE,dimName),
                    paste0(prefixlist$prefixMMS,"inValueDomain"),
                    paste0(nciDomainValue),
                  type="string"
                    )
  }

  
  ## --------- hasTopConcept ---------
  ## For each unique code
    for (i in 1:nrow(codeSource)){
        add.triple(store,
               paste0(prefixlist$prefixCODE,dimName),
               paste0(prefixlist$prefixSKOS, "hasTopConcept"),
               paste0(prefixlist$prefixCODE,dimName,"-",codeSource[i,"codeNoBlank"]))
  }

  
#############################################################################
    ## Code values
    hasALL<- FALSE
    hasNONMISS<- FALSE
  for (i in 1:nrow(codeSource)) {

    subjcode<- paste0(prefixlist$prefixCODE,dimName,"-",codeSource[i,"codeNoBlank"])
    codeSubj<- paste0(prefixlist$prefixCODE,dimName,"-",codeSource[i,"codeNoBlank"])

    add.triple(store,
               codeSubj,
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixSKOS, "Concept"))
    add.triple(store,
               codeSubj,
               paste0(prefixlist$prefixRDF,"type" ),
               paste0(prefixlist$prefixCODE, capDimName))
    add.triple(store,
               codeSubj,
               paste0(prefixlist$prefixSKOS,"topConceptOf"),
               paste0(prefixlist$prefixCODE, dimName))
    add.triple(store,
               codeSubj,
               paste0(prefixlist$prefixSKOS,"inScheme"),
               paste0(prefixlist$prefixCODE, dimName))
    add.data.triple(store,
                    codeSubj,
                    paste0(prefixlist$prefixSKOS,"prefLabel"),
                    paste0(codeSource[i,"code"]),
                    type="string"
                    )
      if (! hasALL     ) { hasALL<- codeSource[i,"code"]=="_ALL_" }
      if (! hasNONMISS ) { hasNONMISS<- codeSource[i,"code"]=="_NONMISS_" }
      
      if (codeSource[i,"code"]!="_ALL_" & codeSource[i,"code"]!="_NONMISS_") {
          if (extension.rrdfqbcrnd0) {
              add.data.triple(store,
                              codeSubj,
                              paste0(prefixlist$prefixRRDFQBCRND0, "R-selectionoperator"),
                              "==",
                              type="string"
                              )
              
              if (mode(codeSource[i,"code"])=="character") {
                  add.data.triple(store,
                                  codeSubj,
                                  paste0(prefixlist$prefixRRDFQBCRND0, "R-selectionvalue"),
                                  paste0('\\"',codeSource[i,"code"], '\\"'),
                                  type="string"
                                  )
              }  else {
                  add.data.triple(store,
                                  codeSubj,
                                  paste0(prefixlist$prefixRRDFQBCRND0, "R-selectionvalue"),
                                  paste0(codeSource[i,"code"]),
                                  type="string"
                                  )
              }
          }
      }
      
      
    ## Should only be added if data available in D2RQ format
    ## ToDo(mja): the stem for the URI for the property is hard coded - this should be changed to use a prefix
    ## ToDo(mja): The derivation of property name should be more integrated with D2RQ
    if (!is.null(underlDataSetName) & dimName=="factor" & ! (codeSource[i,"code"] %in% c("quantity","proportion") ) ) {
        datasetname.subject<- paste0(prefixlist$prefixRRDFQBCRND0,toupper(underlDataSetName),"_", toupper(codeSource[i,"code"]))
        if (extension.rrdfqbcrnd0) {
            add.triple(store,
                  codeSubj,
                  paste0(prefixlist$prefixRRDFQBCRND0, "DataSetRefD2RQ"),
                  datasetname.subject
                  )
            add.triple(store,
                  datasetname.subject,
                  paste0(prefixlist$prefixRRDFQBCRND0, "D2RQ-PropertyBridge"),
                  paste0("http://www.example.org/datasets/vocab/", toupper(underlDataSetName), "_", toupper(codeSource[i,"code"]) )
                  )
            add.data.triple(store,
                  datasetname.subject,
                  paste0(prefixlist$prefixRRDFQBCRND0, "D2RQ-DataSetName"),
                  toupper(underlDataSetName),
                  type="string"
                  )
        }
    }

      ## Document when the codes come from the source data without reconciliation
    ##   against other sources.
    if (codeType=="DATA" & dimName!="procedure"){
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixRDFS, "comment"),
                      "Coded values from data source. No reconciliation against another source",
                      lang="en")
    }
    ## SDTM Terminology
    ##  Additional triples available from the SDTM Terminology file.
    if (codeType=="SDTM"){
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixCTS,"cdiscSynonym"),
                      paste0(codeSource[i,"cdiscSynonym"]))

      ## Remove the prefix colon to specify the value directly (without prefix)
      nciDomain<-gsub("sdtmct:","",codeSource[i,"nciDomain"])

      ## ?  MMS may be incorrect here. How refer back to sdtm-terminology?
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixMMS,"nciDomain"),
                      paste(nciDomain))
      ## add.data.triple(store,
      ##                 codeSubj,
      ##                 paste0(prefixlist$prefixSKOS,"prefLabel"),
      ##                 paste0(codeSource[i,"code"],"-A123"),
      ##                 type="string")
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixCTS,"cdiscDefinition"),
                      paste0(codeSource[i,"cdiscDefinition"]))

      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixCTS,"cdiscSubmissionValue"),
                      paste0(codeSource[i,"code"]))
    }
  }

  ## _NONMISS_
  ##   Cross reference:  _NONMISS_ creation for TopConcept.
  ## TODO: Create function that creates _NONMISS_ based on either presence in data
  ##       or function parameter.
  ##      It is merely coincidental that the Terminology values in the current
  ##       example both have _NONMISS_ .  This logic MUST change.

  
  if ( dimName=="procedure") {
    ## TODO(mja): not straightforward, make more clear
    proc<-GetDescrStatProcedure()
    for (i in 1:nrow(codeSource)){
        ## The two variables should be the same codeSubjInList and codeSubj
      codeSubjInList<- paste0("code:",dimName,"-",codeSource[i,"codeNoBlank"])
      codeSubj<- paste0(prefixlist$prefixCODE,dimName,"-",codeSource[i,"codeNoBlank"])
      if (codeSubjInList %in% names(proc)) {
          if (extension.rrdfqbcrnd0) {
          add.data.triple(store,
                        codeSubj,
                        paste0(prefixlist$prefixRRDFQBCRND0, "RdescStatDefFun"),
                        paste0(deparse(proc[[codeSubjInList]]$fun), collapse=" ")
                        )
          }
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixRDFS, "comment"),
                      paste("Descriptive statistics", codeSource[i,"codeNoBlank"], sep=" ", collapse=" "),
                      lang="en")
      }
    }
  } else {

      if (! hasNONMISS ) {
      add.triple(store,
                 paste0(prefixlist$prefixCODE,dimName),
                 paste0(prefixlist$prefixSKOS, "hasTopConcept"),
                 paste0(prefixlist$prefixCODE,dimName,"-_NONMISS_"))

      codeSubj<- paste0(prefixlist$prefixCODE, dimName,"-_NONMISS_")
      add.triple(store,
                 codeSubj,
                 paste0(prefixlist$prefixRDF,"type" ),
                 paste0(prefixlist$prefixSKOS,"Concept"))
      add.triple(store,
                 codeSubj,
                 paste0(prefixlist$prefixRDF,"type" ),
                 paste0(prefixlist$prefixCODE, capDimName))
      add.triple(store,
                 codeSubj,
                 paste0(prefixlist$prefixSKOS,"topConceptOf"),
                 paste0(prefixlist$prefixCODE, dimName))
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixSKOS,"prefLabel"),
                      "_NONMISS_",
                      type="string"
                      )
      add.triple(store,
                 codeSubj,
                 paste0(prefixlist$prefixSKOS,"inScheme"),
                 paste0(prefixlist$prefixCODE, dimName))
      }
      add.data.triple(store,
                      codeSubj,
                      paste0(prefixlist$prefixRDFS, "comment"),
                      "NON-CDISC: Represents the non-missing codelist categories. Does not include missing values.",
                      lang="en")
      if (extension.rrdfqbcrnd0) {
      add.data.triple(store,
                  codeSubj,
                  paste0(prefixlist$prefixRRDFQBCRND0, "R-selectionfunction"),
                  "is.na",
                  type="string"
                  )
      }
          

      ## _ALL_
      ##   Cross reference:  _ALL_ creation for TopConcept.
      ## TODO: Create function that creates _ALL_ based on either presence in data
      ##       or function parameter.
      ##       It is merely coincidental that the Terminology values in the current
      ##       example both have _ALL_ .  This logic MUST change.


      if (!hasALL) {
      add.triple(store,
                 paste0(prefixlist$prefixCODE,dimName),
                 paste0(prefixlist$prefixSKOS, "hasTopConcept"),
                 paste0(prefixlist$prefixCODE,dimName,"-_ALL_"))

      add.triple(store,
                 paste0(prefixlist$prefixCODE, dimName,"-_ALL_"),
                 paste0(prefixlist$prefixRDF,"type" ),
                 paste0(prefixlist$prefixSKOS,"Concept"))
      add.triple(store,
                 paste0(prefixlist$prefixCODE, dimName,"-_ALL_"),
                 paste0(prefixlist$prefixRDF,"type" ),
                 paste0(prefixlist$prefixCODE, capDimName))
      add.triple(store,
                 paste0(prefixlist$prefixCODE, dimName,"-_ALL_"),
                 paste0(prefixlist$prefixSKOS,"topConceptOf"),
                 paste0(prefixlist$prefixCODE, dimName))
      add.data.triple(store,
                      paste0(prefixlist$prefixCODE, dimName,"-_ALL_"),
                      paste0(prefixlist$prefixSKOS,"prefLabel"),
                      "_ALL_",
                      type="string"
                      )
      add.triple(store,
                 paste0(prefixlist$prefixCODE, dimName,"-_ALL_"),
                 paste0(prefixlist$prefixSKOS,"inScheme"),
                 paste0(prefixlist$prefixCODE, dimName))
      }
      add.data.triple(store,
                      paste0(prefixlist$prefixCODE, dimName,"-_ALL_"),
                      paste0(prefixlist$prefixRDFS, "comment"),
                      "NON-CDISC: Represents all codelist categories.",
                      lang="en")
    }
    
    invisible(TRUE)
  } 
