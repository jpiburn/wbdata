
#' Set the Value of a Missing Function Argument
#'
#' A simple wrapper around ifelse with the condition set to missing(x)
#'
#' @param x A function argument
#' @param true What to return if x is missing. Default is `NA`
#' @param false What to return if x is not missing. Default to return itself
if_missing <- function(x, true = NA, false = x) {
  ifelse(missing(x), true, false)
}





