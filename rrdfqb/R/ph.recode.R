##' @title Return code for value using codelist
##' @param s A value interpreted as character
##' @param l A named list using the value as name as part of a URI
##' @return s capitalized
##' @export ph.recode
ph.recode<- function( s, l ) {
  if (s %in% names(l)) {
    return(l[[as.character(s)]])  # as.character !!!
 } else {
    warning( paste0( 'Value "', s, '" -- ', 'CODING ERROR- no decode value'))
    return('CODING_ERROR-_no_decode_value')
  }
}

