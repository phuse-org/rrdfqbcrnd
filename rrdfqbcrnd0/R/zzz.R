##' @noRd
##

env <- new.env(parent=emptyenv()) 

#  Following http://stackoverflow.com/questions/12598242/global-variables-in-packages-in-r

.onLoad <- function(libname, pkgname) {

env[["rrdfqbcrnd0"]]<-  list(
 "rrdfqbcrnd0"="http://www.example.org/rrdfqbcrnd0/"
)  

  invisible()
}

