##' Get list of Descriptive statistics
##'
##' For q1 and q3 type=2 is used, as it gives same results as SAS. However,
##' the R help on quantile states type=3 gives same result as SAS.
##' TODO(MJA): investigate which definition is the preferable.
##' @return List providing function for each descriptive statistics
##' @export


GetDescrStatProcedure<- function( ) {

list(
    "code:procedure-mean"=list(fun=function(x){mean(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-stddev"=list(fun=function(x){sd(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-stdev"=list(fun=function(x){sd(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-std"=list(fun=function(x){sd(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-median"=list(fun=function(x){median(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-min"=list(fun=function(x){min(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-max"=list(fun=function(x){max(x, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-n"=list(fun=function(x){length(x[!is.na(x)])}, univfunc="univfunc1" ),
    "code:procedure-q1"=list(fun=function(x){quantile(x, probs=c(0.25),type=2, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-q3"=list(fun=function(x){quantile(x, probs=c(0.75),type=2, na.rm=TRUE)}, univfunc="univfunc1" ),
    "code:procedure-count"=list(fun=function(x){length(x)}, univfunc="univfunc2" ),
    "code:procedure-countdistinct"=list(fun=function(x){length(unique(x))}, univfunc="univfunc2" ),
    "code:procedure-percent"=list(fun=function(x){-1}, univfunc="univfunc3" )
  )
}
