#' Title
#'
#' @param dir
#' @param lang
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
refresh_cache <- function(dir, lang, ...) {

  op <- options()
  cache_dir <- op$wbdata.cache_dir
  check_mark <- check_mark_text()


# check dir --------------------------------------------------------------
  if (missing(dir) && is.null(cache_dir)) {

      default_dir <- file.path("~", ".wbdata-cache")
      cat(
        "No directory was specified. Defaulting the wbdata cache directory to\n",
        default_dir, "\n"
      )

      if (!dir.exists(default_dir)) dir.create(default_dir)
      options(wbdata.cache_dir = default_dir)
  }

  if (missing(dir) && !is.null(cache_dir)) {
    if (!dir.exists(cache_dir)) dir.create(cache_dir)
  }

  if (!missing(dir) && is.null(cache_dir)) {
    if (!dir.exists(dir)) dir.create(dir)

    cat("Setting wbdata cache directory to\n", dir, "\n")
    options(wbdata.cache_dir = dir)
  }

  if (!missing(dir) && !is.null(cache_dir)) {
    if (!dir.exists(dir)) dir.create(dir)

    if (dir != cache_dir) {
      cat("Updating wbdata cache directory to\n", dir, "\n")
      options(wbdata.cache_dir = dir)
    }
  }

dir <- options()$wbdata.cache_dir

# check language ----------------------------------------------------------
  if (missing(lang)) lang <- op$wbdata.lang
  if (is.null(lang)) lang <- "en"



# run updates -------------------------------------------------------------
  cat("refreshing countries...")
  countries <- get_countries(lang)
  cat(check_mark,"\n")

  cat("refreshing indicators...")
  indicators <- get_indicators(lang)
  cat(check_mark,"\n")

  cat("refreshing sources...")
  sources <- get_sources(lang)
  cat(check_mark,"\n")

  cat("refreshing topics...")
  topics <- get_topics(lang)
  cat(check_mark,"\n")

  cat("refreshing regions...")
  regions <- get_regions(lang)
  cat(check_mark,"\n")

  cat("refreshing income levels...")
  income_levels <- get_income_levels(lang)
  cat(check_mark,"\n")

  cat("refreshing lending types...")
  lending_types <- get_lending_types(lang)
  cat(check_mark,"\n")

  cat("refreshing languages...")
  languages <- get_languages(lang)
  cat(check_mark,"\n")


  wb_cache <- list(
    countries     = countries,
    indicators    = indicators,
    sources       = sources,
    topics        = topics,
    regions       = regions,
    income_levels = income_levels,
    lending_types = lending_types,
    languages     = languages
  )
 # need to make into list, then save
  # then update the options timestamp and filepath
  saveRDS(wb_cache, file = file.path(dir, "wb_cache.rds"))

  options(wbdata.cache_timestamp = Sys.time())

  invisible(dir)
}


refresh_cache_on_load <- function(refresh_on_load = TRUE) {
  options(wbdata.refresh_cache_on_load = refresh_on_load)

  invisible(refresh_on_load)
}


read_cache <- function(dir) {

}

check_refresh_on_load <- function(fresh_limit = 7, units = "days") {
  op <- options()

  if (op$wbdata.refresh_cache_on_load) {

    cache_timestamp <- op$wbdata.cache_timestamp

    if (is.null(cache_timestamp)) refresh_cache()
    else {
      time_since_last_cache <- difftime(Sys.time(),
                                        cache_timestamp,
                                        units = units)

      if (time_since_last_cache >= fresh_limit) {
        cat("wbdata cache hasn't updated in", round(time_since_last_cache, 1),
            units, "\n")
        refresh_cache()
        cat("To disable auto refresh in the future, run the following command\n",
            "`options(wbdata.refresh_cache_on_load = FALSE)`")
      }
    }

  }

invisible(TRUE)
}

