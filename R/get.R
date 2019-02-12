#' Title
#'
#' @param end_point
#' @param lang
#' @param ...
#'
#' @return
#'
#' @noRd
get_end_point <- function(end_point, lang, ...) {

  get_url <- build_get_url(end_point, lang = lang)

  d <- fetch_wb_url(get_url)
  d_names <- format_wb_tidy_names(names(d), end_point = end_point)
  names(d) <- d_names

  format_wb_data(d, end_point = end_point)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_countries <- function(...) {
  get_end_point("country", ...)
}


#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_topics <- function(...) {
  get_end_point("topic", ...)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_sources <- function(...) {
  get_end_point("source",...)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_regions <- function(...) {
  get_end_point("region", ...)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_income_levels <- function(...) {
  get_end_point("income_level", ...)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_lending_types <- function(...) {
  get_end_point("lending_type", ...)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_languages <- function(...) {
  get_end_point("language", lang = NA)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_indicators <- function(...) {
  get_end_point("indicator", ...)
}

#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
get_cache <- function(...) {
  list(
    countries     = get_countries(...),
    indicators    = get_indicators(...),
    sources       = get_sources(...),
    topics        = get_topics(...),
    regions       = get_regions(...),
    income_levels = get_income_levels(...),
    lending_types = get_lending_types(...),
    languages     = get_languages(...)
  )
}
