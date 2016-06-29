##' Make HTML table representing RDF data cube
##' @param store RDF data store containing cube
##' @param rowdim Row dimensions
##' @param coldim Column dimensions
##' @param idrow idrows
##' @param idcol idcols
##' @param htmlfile path to file with HTML
##' @param useRDFa if TRUE include RDFa markup (default)
##' @param compactDimColumns if TRUE compact dimension columns and add pretty header (default)
##' @param showProcedure If TRUE show in each row the projection procedurevalue
##' @param debug If TRUE give debug information
##' @return path to file with HTML
##' @inheritParams GetObservationsSparqlQuery
##' @export

MakeHTMLfromQb<- function( store, forsparqlprefix, dsdName, domainName,
                          dimensions, rowdim, coldim, idrow, idcol,
                          htmlfile=NULL, useRDFa=TRUE, compactDimColumns=TRUE,
                          showProcedure=TRUE, debug=FALSE ) {

# ToDo(mja): the result from GetTwoDimTableFromQb is wrong
    qbtest<- GetTwoDimTableFromQb( store, forsparqlprefix, domainName, rowdim, coldim )

    ## names(attributes(qbtest))
    ## options(width=200)
    ## knitr::kable(qbtest[order(strtoi(qbtest$rowno)),])

    oDx<-attr(qbtest,"observationsDesc")
    ## knitr::kable(oDx)
    oDxx<- oDx[! is.na(oDx$s),]
    oD<- oDxx[order(strtoi(oDxx$rowno)),]
    ## print(colnames(oD))
    ## TODO(mja): ensure measurefmt is always defined - this is a quick fix
    if (!("measurefmt" %in% names(oD))) {
        oD$measurefmt<- " "
    }
    presrowvarindex<- unique(oD$rowno)
    colvarindex<- unique(oD$colno)
    cellpartnoindex<- unique(oD$cellpartno)

    Showit<- function() {
        print(presrowvarindex)
        print(colvarindex)
        print(cellpartnoindex)
        print(oD[,c("s","rowno","colno","cellpartno")])
    }

if (debug) {     Showit() }

    # Determine variable names in Od dataframe
    presrowvarvalue<- gsub("(crnd-dimension:|crnd-attribute:|crnd-measure:)(.*)","\\2value", rowdim)
    presrowvarIRI  <- gsub("(crnd-dimension:|crnd-attribute:|crnd-measure:)(.*)","\\2IRI",   rowdim)
    presrowvarlabel<- gsub("(crnd-dimension:|crnd-attribute:|crnd-measure:)(.*)","\\2label", rowdim)

    presidcolvalue<- gsub("(crnd-dimension:|crnd-attribute:|crnd-measure:)(.*)","\\2value", idcol)
    presidcollabel<- gsub("(crnd-dimension:|crnd-attribute:|crnd-measure:)(.*)","\\2label", idcol)

    ## add code for embedding the cube as turtle
    ## determine cube compontents except observations,
    ## as the observations are stored as RDFa

    if (is.null(htmlfile)) {
        htmlfile<- file.path(system.file("extdata/sample-cfg", package="rrdfqbpresent"), "test.html")
                                        # htmlfile<- file.path(tempdir(),"test.html")
    }

    cat("<!DOCTYPE HTML>\n", file=htmlfile, append=FALSE)
    cat('
<html>
<head>
<meta charset="UTF-8">
<title>DEMO table as html</title>
',
ifelse(useRDFa,
       '    
   <script src="jquery-2.1.3.min.js"></script>
   <link rel="stylesheet" href="jquery-ui-1.11.3.custom/jquery-ui.css"/>
   <script src="jquery-ui-1.11.3.custom/jquery-ui.min.js"></script>
   <script src="RDFa.min.1.4.0.js"></script>
', ''),
## '    
## <style>
## #table {
##     line-height:30px;
##     background-color:#eeeeee;
##     height:1000px;
##     width:750px;
##     float:left;
##     padding:5px;
## }
## #drop{
##     width:300px;
##     background-color:green;
##     float:left;
##     padding:10px;
## }
## ',
'    
</style>

</head>
<script>
"use strict";
'
,
## '    
## function allowDrop(ev)
## {
## ev.preventDefault();
## }

## function drag(ev)
## {
## ev.dataTransfer.setData("Text",ev.target.id);
## console.log("Dragging: ", ev.target.id);
## }

## function drop(ev)
## {
## ev.preventDefault();
## var data=ev.dataTransfer.getData("Text");
## console.log("Dropping: ", data);
## // from http://stackoverflow.com/questions/13007582/html5-drag-and-copy
## var nodeCopy = document.getElementById(data).cloneNode(true);
## nodeCopy.id = "copy"+nodeCopy.id;
## // end from http://stackoverflow.com/questions/13007582/html5-drag-and-copy
## var newelem = document.createElement("P");
## newelem.appendChild(nodeCopy);
## ev.target.appendChild(newelem);
## }

## $(document).ready(function(){

## GreenTurtle.attach(document)

## })
## ',
'
function obsclick(obssubject)
{
  alert("Observation " + obssubject )
}  
'
,    
'                 
</script>
<body>
  <h1>',
dsdName,
'</h1>
'
, file=htmlfile, append=TRUE
)

    cat('<div id="container">', file=htmlfile, append=TRUE)

    cat("<div id='table'>\n", file=htmlfile, append=TRUE)
    cat("<table border>\n", file=htmlfile, append=TRUE)

    if (TRUE || compactDimColumns) {
        useidrow<- vector(mode="character",length=0)
        hasallidrow<- vector(mode="character",length=0)
        useidheader<- vector(mode="character",length=0)
        maxNoOfNonALL<-0
        # has to use to OR approach to identify the cells that goes in the same rowno!! 
        or<- 1
        for (rr in presrowvarindex) {
            thisNoOfNonALL<-0
            for (rowidname in idrow) {
if (debug) {                 cat("Row ", rr, ", observation (or) ", or, ", rowidname", rowidname, ", contents: ", oD[or,rowidname],  "\n") }
                if ( is.na(oD[or,rowidname]) || oD[or,rowidname]=="_ALL_" ) {
                    if (!is.element(rowidname,hasallidrow) ) {
                        hasallidrow<- c(hasallidrow, rowidname)
                    } 
                } else {
                        thisNoOfNonALL<-thisNoOfNonALL+1
                    }
            }
##            cat("THis no columns with not ALL ", thisNoOfNonALL, "\n" )

            maxNoOfNonALL<- max(maxNoOfNonALL, thisNoOfNonALL)

            ## Advance to next row
            for (cc in colvarindex) {
                cpindex<-0
                for (cp in cellpartnoindex) {
                    cpindex<- cpindex+1
                    if (oD$rowno[or]==rr & oD$colno[or]==cc & oD$cellpartno[or]==cp ) {
                        or<- or+1
                    }
                }
            }
        }
##        cat("Max no columns with not ALL ", maxNoOfNonALL, "\n" )
##        cat("ID rows ", idrow, "\n")
##        cat("ID rows with at least one _ALL_ value", hasallidrow, "\n")
        alwaysshowidrow<- setdiff(idrow, hasallidrow)
##        cat("ID rows with no _ALL_ value", alwaysshowidrow, "\n")
    }
    
    ## make the header row(s) for the columns

    headerrowvarindex<- c(1)
    or<- 1

    for (rr in headerrowvarindex) {
        cat("<tr>", file=htmlfile, append=TRUE)
                                        # print(rr)

        if (!compactDimColumns) {
            ## START make the row identification
            for (rowidname in idrow) {
                ##                cat("<th>", rowidname,  "</th>", file=htmlfile, append=TRUE)
                ## this is not a long term approach
                cat("<th><a href=\"",oD[or,gsub("(^.*)value$","\\1IRI",rowidname)],"\">", oD[or,gsub("(^.*)value$","\\1label",rowidname)],  "</a></th>", file=htmlfile, append=TRUE)
                

            }
            ## END make the row identification
        } else {
        }
        

        ## START identify all column related information to be projected into column
        if (showProcedure) {
        cat("<th>", "Variable",  "</th>", file=htmlfile, append=TRUE)
        cat("<th>", "Statistics",  "</th>", file=htmlfile, append=TRUE)
        }
        ## END identify all column related information to be projected into column
        
        for (cc in colvarindex) {
            cpindex<-0
            cat("<th colspan=\"", length(cellpartnoindex), "\">", file=htmlfile, append=TRUE)
            prevvalue<- " "
            for (cp in cellpartnoindex) {
                cpindex<- cpindex+1
##                cat( oD[or, presidcolvalue ] , file=htmlfile, append=TRUE)
                ## TODO: make better solution
                if (prevvalue != oD[or,presidcolvalue]) {
                    cat("<a href=\"",oD[or,gsub("(^.*)value$","\\1",presidcolvalue)],"\">", oD[or,presidcolvalue],  "</a>", file=htmlfile, append=TRUE)
                    prevvalue<- oD[or,presidcolvalue]
                }
                or<- or+1
            }
            cat("</th>\n", file=htmlfile, append=TRUE)

        }
        cat("</tr>", "\n", file=htmlfile, append=TRUE)
    }

    ## data rows
    or<- 1
    
if (debug) {    cat("Start data rows\n")     }
    for (rr in presrowvarindex) {
        if (debug) { cat("Data rows: Row ", rr, ", observation (or) ", or, ", rowidname", rowidname, ", contents: ", oD[or,rowidname],  "\n") }
        cat("<tr>", file=htmlfile, append=TRUE)
                                        # print(rr)

        ## START make the row identification
        if (oD$rowno[or]==rr) {
            for (rowidname in idrow) {
                ## this is not a long term approach
                cat("<td>",
                    "<a href=\"",oD[or,gsub("(^.*)value$","\\1",rowidname)],"\">",
                    oD[or,rowidname],
                    "</a>",
                    "</td>", file=htmlfile, append=TRUE)
            }
        }
        ## END make the row identification
        
        ## START identify all column related information to be projected into column
        if (showProcedure) {
            xor<- or
            xrowid<- rep("", length(cellpartnoindex))
            yrowid<- rep("", length(cellpartnoindex))
            
            for (cc in colvarindex) {
                cpindex<-0
                for (cp in cellpartnoindex) {
                    cpindex<- cpindex+1
                    if (oD$rowno[xor]==rr & oD$colno[xor]==cc & oD$cellpartno[xor]==cp ) {
                        if (!is.na(oD$factorvalue[xor]) && yrowid[cpindex]=="") {
                            yrowid[cpindex]<-paste0("<a href=\"",oD$factor[xor],"\">",
                                                    oD$factorvalue[xor], "</a>",collapse="")
                        }
                        if (!is.na(oD$procedurevalue[xor]) && xrowid[cpindex]=="") {
                            xrowid[cpindex]<-paste0("<a href=\"",oD$procedure[xor],"\">",
                                                    oD$procedurevalue[xor], "</a>",collapse="")
                        }
                        xor<- xor+1
                    }
                }
            }
            cat("<td>", paste(yrowid,collapse=", ",sep=""),  "</td>", file=htmlfile, append=TRUE)
            cat("<td>", paste(xrowid,collapse=", ",sep=""),  "</td>", file=htmlfile, append=TRUE)
        }
        
        ## END identify all column related information to be projected into column
        ## 
        for (cc in colvarindex) {
            cpindex<-0
            for (cp in cellpartnoindex) {
                cpindex<- cpindex+1
                cat("<td>", file=htmlfile, append=TRUE)
                ## if (cpindex>1) {
                ## ## separator between cells should be taken from data
                ##       cat(" ", file=htmlfile, append=TRUE)
                ## }
                if (debug) {
                    cat("colvarindex:",
                    " rowno ", oD$rowno[or],"==", rr,
                    " colno ", oD$colno[or], "==", cc,
                    " cellparno ", oD$cellpartno[or], "==", cp,
                    "\n" )
                }
                if (oD$rowno[or]==rr & oD$colno[or]==cc & oD$cellpartno[or]==cp ) {
                    ## The observation
                    ## next line is for simple fly-over
                    if (useRDFa) {
                        cat(paste0("<a title=\"", oD$measureIRI[or], "\"",
                                   " onclick=obsclick(\"", oD$measureIRI[or], "\")",
                                   ">\n" ), file=htmlfile, append=TRUE)
                        cat(paste0('<span ', 'id="', gsub("ds:","",oD$s[or]), '"',
                                   'resource="', oD$s[or],'"',
                                   ' typeof="qb:Observation" ',
                                   ## TODO(mja): how to use draggable: Disable draggable for now
                                   ## ' draggable="true" ondragstart="drag(event)"',
                                   '>\n' ),
                            file=htmlfile, append=TRUE)
                    } else {
                        cat(paste0("<a href=\"", oD$measureIRI[or], "\"",
                                   ">\n" ), file=htmlfile, append=TRUE)
                    }
                    
                    ## TODO(mja) how to store dataSet information
                    ## cat(paste0('<span property="qb:dataSet" resource="', 'ds:', dsdName,'">\n' ), file=htmlfile, append=TRUE)

                    ## TODO(mja) how to show dimensions       
                    ## for (prop in dimensions) {
                    ## cat( paste0('<span property="', prop, '"', ' resource="', oD[or, gsub("crnd-dimension:|crnd-attribute:|crnd-measure:", "", prop)], '">\n' ), file=htmlfile, append=TRUE)
                    ## }

if (debug) {                     cat("Observation: ", oD$measure[or],"\n" )                    }
                    ## formatting to applied to measure
                    if (oD$measurefmt[or] != " ") {
                        cat(sprintf(oD$measurefmt[or],as.numeric(oD$measure[or])), file=htmlfile, append=TRUE)
                    }
                    else {
                        cat(paste0(oD$measure[or]), file=htmlfile, append=TRUE)
                    }
                    ## for (prop in dimensions) {
                    ## cat( '</span>\n', file=htmlfile, append=TRUE)
                    ## }
                    ## dataSet information
                    ## cat( '</span>\n', file=htmlfile, append=TRUE)
                    if (useRDFa) {
                        cat( '</span>\n', file=htmlfile, append=TRUE)
                    }
                    cat(paste0("</a>\n"), file=htmlfile, append=TRUE)
                    or<- or+1
                    cat("</td>\n", file=htmlfile, append=TRUE)
                }
            }
                                        #    cat("</td>\n", file=htmlfile, append=TRUE)
        }
        cat("</tr>", "\n", file=htmlfile, append=TRUE)
if (debug) { cat("End of for, or ", or, "\n" ) }
    }


    cat("</table>\n", file=htmlfile, append=TRUE)
    cat("</div>\n", file=htmlfile, append=TRUE)

    ## TODO(mja): consider how to use this with dropping
    ## cat('
    ## <div id="droparea">
    ## Drag and drop over the green text below.
    ## <table>
    ## <tr><td>
    ## <span  style="width:100px" id="drop" ondrop="drop(event)" ondragover="allowDrop(event)">Drop here...</span>
    ## </td></tr>
    ## </table>
    ## </div> 
    ## ',  file=htmlfile, append=TRUE)                 

    cat('
</div>
</body>
</html>
', file=htmlfile, append=TRUE)


    htmlfile

}
