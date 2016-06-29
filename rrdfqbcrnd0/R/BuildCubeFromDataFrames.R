##' Build a RDF data cube based on specification 
##'
##' 
##' @param cubeMetadata data.frame with metadata
##' @param obsData data.frame with observations
##' @param common.prefixes data.frame commom prefixes, if NULL a built in default value is used
##' @param endpoint Used for determined codelist for dimensions. When
##' codetype="SDTM" to give the URL for the remote endpoint. If NULL
##' then the local rdf.cdisc.store from the environment is used.
##' @return The filename for the generated turtle file
##' @export

BuildCubeFromDataFrames<- function(cubeMetadata, obsData, common.prefixes=NULL, endpoint=NULL) {
    

    ## Cube metadata. 
    cubeDescription<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="description",defaultValue="** no description given **" )
    cubeComment<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="comment",defaultValue="** no comment given **" )
    cubeLabel<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="label",defaultValue="** no label given **" )
    cubeTitle<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="title",defaultValue="** no title given **" )
    domainName<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="domainName",defaultValue="notgiven" )
    obsFile<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="obsFileName",defaultValue="notgiven" )
    obsURL<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="obsURL",defaultValue="notgiven" )
    extension.rrdfqbcrnd0.ch<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="extension.rrdfqbcrnd0",defaultValue="FALSE" )
    obsDataSetName<- toupper(tools::file_path_sans_ext(basename(obsURL)))
    
    ## Output file format: DC-<domain>-R-Vn-n-(n).TTL . Also used in dcat:distribution
    ## NOTE: For pav:Version (dot, notdash) and output file name
    cubeVersion <- gsub("\\.","-",GetValueFromMetadata(cubeMetadata,compType="metadata",compName="cubeVersion",defaultValue="0.0.0" ))

    dataCubeOutDirectory<- GetValueFromMetadata(cubeMetadata,compType="metadata",compName="dataCubeOutDirectory",defaultValue=tempdir() )

    if (dataCubeOutDirectory=="!temporary" ) {
        dataCubeOutDirectory<- tempdir()
    }
    
    dataCubeFileName  <- paste0("DC-", domainName,"-R-V-",cubeVersion,".ttl")   
    dataCubeFile      <- file.path(dataCubeOutDirectory,dataCubeFileName) ## Full path to cube

    ## Get the analysis results - which will be the Cube Observation data       

    ## Forcing variable names to lower case
    ## TODO: consider if this should be handled else where
    names(obsData)<- tolower(names(obsData))

    ## Subset to the dimensions, attributes, and measure used to construct the skeleton
    skeletonSource <-cubeMetadata[grep("dimension|attribute|measure", cubeMetadata$compType),]

    prefixes<- GetForSparqlPrefix.as.df(domainName=domainName, common.prefixes=common.prefixes )

    store <- new.rdf()  ## Initialize

    ## Register prefixes and return prefixlist
    ## Examples: prefixQB   holds value http://purl.org/linked-data/cube#
    ##             prefixRDFS holds value http://www.w3.org/2000/01/rdf-schema#

    prefixlist<- qb.def.prefixlist(store, prefixes)

    qb.buildSkeleton(store, prefixlist, obsData, skeletonSource)

    ### TODO: Issue How to handle multiple terminology files for code list generation?
    qb.buildDSD(store, prefixlist, obsData, skeletonSource,
                dsdURIwoprefix=paste0("dataset-",domainName),
                dsdName=paste0("dsd-",domainName),
                extra=list(description=cubeDescription,
                           comment=cubeComment,
                           label=cubeLabel,
                           distribution=dataCubeFileName,
                           obsfilename=obsFile,
                           obsDataSetName=obsDataSetName,
                           title=cubeTitle,
                           PAVnodes=list(
                               createdOn=gsub("(\\d\\d)$", ":\\1",strftime(Sys.time(),"%Y-%m-%dT%H:%M:%S%z")),
                               createdBy="username or session name",
                               pavVersion=GetValueFromMetadata(cubeMetadata,compType="metadata",compName="cubeVersion",defaultValue="0.0.0" ),
                               createdWith=paste0("R Version ", R.version$major, ".", R.version$minor,
                                                  " Platform:", R.version$platform, " rrdfqbrnd0 package and dependencies"),
                               providedBy="PhUSE Analysis Results and Metadata Working Group"
                           )
                           ),
                remote.endpoint=endpoint,
                extension.rrdfqbcrnd0= (extension.rrdfqbcrnd0.ch=="TRUE")
                ##            codelist.source=sdtm.terminology
                )

    qb.buildObservations(
        store=store,
        prefixlist=prefixlist,
        obsData=obsData,
        skeletonSource=skeletonSource,
        dsdURIwoprefix=paste0("dataset-", domainName),
        dsdName=paste0("dsd-",domainName),
        recode.list=NULL,
        procedure2format=NULL
    )

    ## Output 
    outcube <- save.rdf(store, filename=dataCubeFile, format="TURTLE")
    outcube
}
