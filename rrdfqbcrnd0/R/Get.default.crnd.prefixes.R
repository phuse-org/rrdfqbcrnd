##' Get list of default prefixes
##'
##' @return List with default prefixes
##' @export Get.default.crnd.prefixes
Get.default.crnd.prefixes<- function( ) {
    
    c(
        rrdfcdisc:::env[["qbCDISCprefixes"]],
        rrdfqb:::env[["rrdfqb"]],
        rrdfqbcrnd0:::env[["rrdfqbcrnd0"]]
        )
}
  
