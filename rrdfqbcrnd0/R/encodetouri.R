##' Encode string to URI
##'
##' This function is currently only a gsub - should be more clever and make better URI encoding.
##' @param s A value to be used as URI
##' @return The string{s} encoded as URI
##' @export encodetouri 
# TODO - make better way of doing this
encodetouri<- function( s ) {
  gsub(" |'|,|\\(|\\)|>|<","_", s )
}

