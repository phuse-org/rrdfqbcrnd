##' Get the common PREFIXES for a SPARQL query
##' @return data.frame with columns prefix and namespace
##' @export

GetCommonPrefixDf<- function() {
common.prefixes <- data.frame(
    prefix=gsub("^prefix","",names(Get.default.crnd.prefixes())),
    namespace=as.character(Get.default.crnd.prefixes() ),
    stringsAsFactors=FALSE
    )
}
