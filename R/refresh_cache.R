refresh_cache <- function(path, lang, ...) {

  if (
    requireNamespace("crayon", quietly = TRUE) &
    requireNamespace("clisymbols", quietly = TRUE)
    ) check_mark <- crayon::green(clisymbols::symbol$tick)
  else check_mark <- ""

  cat("updating countries...")
  cn <- get_countries()
  cat(check_mark,"\n")

  cat("updating regions...")
  rg <- get_regions()
  cat(check_mark, "\n")

  cat("updating indicators...")
  ind <- get_indicators()
  cat(check_mark, "\n")


  cat("Cache refreshed", check_mark)
}
