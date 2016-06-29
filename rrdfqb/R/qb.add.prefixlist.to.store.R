##' Add prefixes to a rrdf store and returns list of prefixes
##'
##' Sideeffect: the prefixes are added to the store
##' @param store A rrdf store, if NULL then not added to a store
##' @param prefixes A data.frame with column prefix and namespace
##' @return The list with member names prefixUPPERCASEPREFIX and namespace as value
##' TODO(mja): this should be changed - at least the naming, or use another data structure 
##' @export qb.add.prefixlist.to.store
qb.add.prefixlist.to.store<- function(store=NULL, prefixes) {

for (i in 1:nrow(prefixes))
{
  # Use as.character to typecast
  if (!is.null(store)) {
  add.prefix(store, as.character(prefixes[i,"prefix"]),
                    as.character(prefixes[i,"namespace"]))
}
}

return(TRUE)
}

