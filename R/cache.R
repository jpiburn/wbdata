#' Refresh the wbdata cache
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

  saveRDS(wb_cache, file = file.path(dir, "wb_cache.rds"))

  options(wbdata.cache_timestamp = Sys.time())

  invisible(dir)
}


#' Set wbdata cache to automatically refresh on loading wbdata
#'
#' @param refresh_on_load
#' @param tim
#' @param units
#'
#' @return
#' @export
#'
#' @examples
refresh_cache_on_load <- function(refresh_on_load = TRUE,
                                  tim = 7,
                                  units = "days") {
  options(wbdata.refresh_cache_on_load = refresh_on_load)
  if (refresh_on_load) options(wbdata.cache_life = as.difftime(tim, units = units))

  invisible(refresh_on_load)
}


#' Read wbdata cache from directory
#'
#' @param dir
#'
#' @return
#' @export
#'
#' @examples
read_cache <- function(dir) {
  if (missing(dir)) dir <- options()$wbdata.cache_dir
  if (is.null(dir)) stop("Please provide the cache directory or set
                         a new one by running `refresh_cache()`")

  readRDS(file.path(dir, "wb_cache.rds"))
}


#' Check for cache refresh
#'
#' @return
#'
#' @noRd
check_refresh_on_load <- function() {
  op <- options()

  if (op$wbdata.refresh_cache_on_load) {

    cache_timestamp <- op$wbdata.cache_timestamp

    if (is.null(cache_timestamp)) refresh_cache()
    else {
      time_since_last_cache <- difftime(Sys.time(), cache_timestamp)
      cache_life <- op$wbdata.cache_life

      if (time_since_last_cache >= cache_life) {
        cat("wbdata cache hasn't updated in", round(time_since_last_cache, 1),
            units(time_since_last_cache), "\n")
        refresh_cache()
        cat("To disable auto refresh in the future, run the following command\n",
            "`refresh_cache_on_load(FALSE)`")
      }
    }

  }

invisible(TRUE)
}

