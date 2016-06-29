##' @noRd
##

env <- new.env(parent=emptyenv()) 

#  Following http://stackoverflow.com/questions/12598242/global-variables-in-packages-in-r

.onLoad <- function(libname, pkgname) {

env[["rrdfqb"]]<-  list(
 "qb"="http://purl.org/linked-data/cube#"
)  

  invisible()
}

