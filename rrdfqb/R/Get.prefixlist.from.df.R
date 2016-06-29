##' Return list of prefixes
##'
##' @param prefixes A data.frame with column prefix and namespace
##' @return The list with member names prefixUPPERCASEPREFIX and namespace as value
##' TODO(mja): this should be changed - at least the naming, or use another data structure 
##' @export Get.prefixlist.from.df
Get.prefixlist.from.df<- function(prefixes) {
pl<- list();

for (i in 1:nrow(prefixes))
{

  pl[[ paste0("prefix",toupper(prefixes[i,"prefix"])) ]] <-
      as.character(prefixes[i,"namespace"])
}
return(pl)
}

