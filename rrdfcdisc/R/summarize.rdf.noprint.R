##' Return number of triples in model
##'
##' 
##' @param model RRDF model
##' @return Number of triples in model
##' @details This the rrdf summarize.rdf without a print statement
##' @export summarize.rdf.noprint
summarize.rdf.noprint<- function (model) 
{
    count <- .jcall("com/github/egonw/rrdf/RJenaHelper", "I", 
        "tripleCount", model)
    exception <- .jgetEx(clear = TRUE)
    if (!is.null(exception)) {
        stop(exception)
    }
return(count)
  }
