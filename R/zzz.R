.onLoad <- function(libname, pkgname) {

  op.wbdata <- list(
    wbdata.lang = "en",
    wbdata.cache_dir = NULL,
    wbdata.refresh_cache_on_load = FALSE,
    wbdata.cache_timestamp = NULL
  )

  # if the options are there, set them
  op_to_set <- !(names(op.wbdata) %in% names(options()))
  if(any(op_to_set)) options(op.wbdata[op_to_set])

  check_refresh_on_load()

}
