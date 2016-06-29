##' SPARQL update
##' 
##' @param sparqlUpdateStmts SPARQL update statements string
##' @param model RRDF store
##' @return TRUE
##' @export update.rdf
##' @usage  update.rdf(model, sparqlUpdateStmts)
##'
## Same parameters as construct
## ~/packages/rrdf/rrdf/R/construct.R
## ~/packages/rrdf/rrdf/R/save.rdf.R
## Corresponding java code for RJenaHelper2
## ../java/src/com/github/marcjandersen/rrdfancillary/RJenaHelper2.java

update.rdf <- function(model, sparqlUpdateStmts) {
    .jcall(
        "com/github/marcjandersen/rrdfancillary/RJenaHelper2",
        "V",
        "sparqlUpdate", model, sparqlUpdateStmts
    )
    exception <- .jgetEx(clear = TRUE)
    if (!is.null(exception)) {
        stop(exception)
    }
    TRUE
}
