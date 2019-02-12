
#' Title
#'
#' @param base_url
#' @param indicator_ids
#' @param path_list
#' @param query_list
#'
#' @return
#'
#' @noRd
build_wb_url <- function(base_url, indicator_ids, path_list, query_list) {

  url_path <- unlist(path_list)
  url_path <- url_path[!is.na(url_path)]

  query_list <- query_list[!is.na(query_list)]

  if(missing(indicator_ids)) {
    out_url <- httr::modify_url(base_url, path = url_path, query = query_list)
    return(out_url)
  }

  indicator_path <- url_param_list()$indicators
  indicator_path <- paste0(indicator_path, indicator_ids)

  if(is.null(names(indicator_ids))) names(indicator_path) <- indicator_ids
  else names(indicator_path) <- names(indicator_ids)

  out_url <- sapply(indicator_path, FUN = function(ind) {
    url_path <- c(url_path, ind)
    httr::modify_url(base_url, path = url_path, query = query_list)
  }
  )

  out_url
}


#' Title
#'
#' @param end_point
#' @param lang
#'
#' @return
#'
#' @noRd
build_get_url <- function(end_point, lang) {

  base_url <- wb_api_parameters$base_url

  path_list <- list(
    version = wb_api_parameters$version,
    lang    = if_missing(lang, wb_api_parameters$default_lang, lang),
    path    = wb_api_parameters[[end_point]]
  )

  query_list <- list(
    per_page = wb_api_parameters$per_page,
    format   = wb_api_parameters$format
  )


  wb_url <- build_wb_url(
    base_url   = base_url,
    path_list  = path_list,
    query_list = query_list
  )

  wb_url
}
