##' Add RDF Data Set Specification (DSD) to the rrdf store
##'
##' 
##' @param store RRDF store
##' @param prefixlist prefix list
##' @param skeletonSource data.frame with skeleton source
##' @param dsdURIwoprefix DSD URI
##' @param dsdName DSD name
##' @param extra A list with member names: description, comment, label , distribution, obsfilename, title, PAVnodes, obsDataSetName
##' @return Always TRUE
##' @author Tim Williams, Marc Andersen
##  @inheritParams buildCodelist.R
##' @export qb.buildDSD
qb.buildDSD<- function(store,
  prefixlist,
  obsData,
  skeletonSource,
  dsdURIwoprefix="dataset-demog",
  dsdName="dsd-demog",
  extra=list(
    description=paste0("Cube with 6 Dimensions (factor, procedure, race, saffl, sex, trt01a),",
                      "2 Attributes (denominator, unit) and 1 measure (measure)"),
    comment=paste0("Example Demographics data supplied by Ian Fleming via R. ",
      "All dimensions have a Codelist and Range specified. ",
      "Attributes applied from source data. ",
      "Attributes as VALUES instead of URIs."),
    label="Demographics results data set.",
    distribution="dataCubeFileName",
    obsfilename="the name of the input file",
    obsDataSetName="the name for the data set (D2RQ)",
    title="Demographics Analysis Results",
    PAVnodes=list(
      createdOn=gsub("(\\d\\d)$", ":\\1",strftime(Sys.time(),"%Y-%m-%dT%H:%M:%S%z")),
      createdBy="Tim Williams",
      pavVersion="0.0.0",
      createdWith=paste0("R Version ", R.version$major, ".", R.version$minor, " Platform:", R.version$platform, " rrdfqbrnd0 package and dependencies"),
      providedBy="PhUSE Results Metadata Working Group"
      )
  ),
  remote.endpoint=NULL, 
  extension.rrdfqbcrnd0=FALSE 
#  codelist.source
) {
# -------------  DSD Component ------------------------------------------------
# Loop through to create the dsd component for each dimension, measure, attribute
# Written as a separate loop to keep the dsd more concise in the output file
# Example triple:  ds:dsd-demog qb:component dccs:race
add.triple(store,
           paste0(prefixlist$prefixDS, dsdName),
           paste0(prefixlist$prefixRDF,"type" ),
           paste0(prefixlist$prefixQB, "DataStructureDefinition"))

for (i in 1:nrow(skeletonSource)){
  component <- skeletonSource[i,"compType"]
  add.triple(store,
             paste0(prefixlist$prefixDS, dsdName),
             paste0(prefixlist$prefixQB, "component"),
             paste0(prefixlist$prefixDCCS, skeletonSource[i,"compName"]))
}
#########################
# qb:DataSet definition #
###############################################################################

add.triple(store,
           paste0(prefixlist$prefixDS, dsdURIwoprefix),
           paste0(prefixlist$prefixQB, "structure"),
           paste0(prefixlist$prefixDS, dsdName))
add.triple(store,
           paste0(prefixlist$prefixDS, dsdURIwoprefix),
           paste0(prefixlist$prefixRDF,"type" ),
           paste0(prefixlist$prefixQB, "DataSet"))

# turn this into a for looping over all values in the list extra -
# have to solve how the prefix is included - when generating the list or by
# resolving the prefixes in the list

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixDCT, "title"),
                extra$title,
                "string")
add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixDCT, "description"),
                extra$description,
                lang="en")

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixRDFS, "comment"),
                extra$comment,
                lang="en")
add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixRDFS, "label"),
                extra$label,
                lang="en")

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixDCAT, "distribution"),
                extra$distribution)

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixPAV, "createdOn"),
                extra$PAVnodes$createdOn,
                "dateTime")


add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixPAV, "version"),
                extra$PAVnodes$pavVersion,
                "string")

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixPAV, "createdWith"),
                extra$PAVnodes$createdWith,
                "string")

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixPAV, "createdBy"),
                extra$PAVnodes$createdBy,
                "string")

add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixPROV, "wasDerivedFrom"),
                extra$obsfilename,
                "string"
                )  # The source .CSV data file

        if (extension.rrdfqbcrnd0) {
            add.data.triple(store,
                paste0(prefixlist$prefixDS, dsdURIwoprefix),
                paste0(prefixlist$prefixRRDFQBCRND0, "D2RQ-DataSetName"),
                extra$obsDataSetName,
                "string"
                )  # D2RQ DataSetName
        }    
for (i in 1:nrow(skeletonSource)){
    if (skeletonSource[i,"compType"]=="dimension") {

        ## cat("codeType: ",skeletonSource[i,"codeType"], "\n" )
        ##                 cat("nciDomainValue: ",skeletonSource[i,"nciDomainValue"], "\n")
        ##                 cat("dimName: ",skeletonSource[i,"compName"], "\n")
        ##                 cat("underlDataSetName: ",extra$obsDataSetName, "\n")
        ##                 cat("remote.endpoint: ",remote.endpoint, "\n")         

  buildCodelist(store,
                prefixlist,
                obsData,
                codeType=skeletonSource[i,"codeType"],
                nciDomainValue=skeletonSource[i,"nciDomainValue"],
                dimName=skeletonSource[i,"compName"],
                underlDataSetName=extra$obsDataSetName,
                remote.endpoint=remote.endpoint,
                extension.rrdfqbcrnd0=extension.rrdfqbcrnd0
#                codelist.source=codelist.source
                )
  }
}
invisible(TRUE)
}
