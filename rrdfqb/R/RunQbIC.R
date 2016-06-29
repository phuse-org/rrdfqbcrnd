##' Run the RDF data cube Integrity Constraints
##' The present version does not run IC-20 and IC-21.
##' Note TODO(mja): RRDF does not support the ASK query. This is handled
##' by converting ASK to SELECT.
##' 
##' @param model a RRDF model containing one or more date cubes
##' @param doForIC character vector of specific integrity checks to run
##' @param forsparqlprefix string with the prefix to be used
##' @return data.frame with columns ICtitle, ICfailobs
##' @export
RunQbIC<- function(model, forsparqlprefix, doForIC=NULL ) {

  victitle<- character(length(qbIClist))
  vicfail<- numeric( length(qbIClist))
  nic<-0

  icallnames<- names(qbIClist)
  if (! is.null(doForIC)) {
    icallnames<- intersect(icallnames, doForIC)
  }
  for (icallname in icallnames) {
    icall<- qbIClist[[icallname]]
##    print(names(icall))
##  cat(paste(names(icall), unlist(icall),collapse=": ",sep="\n"),"\n")
  if (! icall$HasInstantiation ) {
    message("Executing ", icall$ictitel)
    nic<- nic+1
    victitle[nic]<- icall$ictitel
    icSelectRq<- gsub("ASK \\{", "SELECT \\* WHERE \\{", icall$rq)
##    cat(icSelectRq,"\n")
    cube.ic<- sparql.rdf(model, paste( forsparqlprefix, icSelectRq  )  )
    vicfail[nic] <- nrow(cube.ic)   
    message(" -- ", nrow(cube.ic), " rows returned (0 is pass, >0 fail)" )
   }
}
  message("IC-20 and IC-21 are currently not implemented")
  
  ICres<- data.frame( ictitle=victitle[1:nic], icfail=vicfail[1:nic] )
}

      
  
  
