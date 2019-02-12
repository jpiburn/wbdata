
#' Title
#'
#' @param url_string
#' @param indicator
#'
#' @return
#'
#' @noRd
fetch_wb_url <- function(url_string, indicator) {

  return_json <- fetch_wb_url_content(url_string = url_string, indicator = indicator)

  return_list <- jsonlite::fromJSON(return_json, simplifyVector = FALSE)

  if ("message" %in% names(return_list[[1]])) {

    message_list <- return_list[[1]]$message[[1]]

    stop(sprintf("World Bank API request failed for indicator %s The following message was returned from the server\nid: %s\nkey: %s\nvalue: %s",
                 indicator,
                 message_list$id,
                 message_list$key,
                 message_list$value),
         call. = FALSE)

  }

  n_pages <- return_list[[1]]$pages

  if (n_pages == 0) return(NA) # a blank data frame will be returned to the user

  return_list <- jsonlite::fromJSON(return_json,  flatten = TRUE)

  lastUpdated <- return_list[[1]]$lastupdated

  if (n_pages > 1) {

    page_list <- lapply(1:n_pages, FUN = function(page) {

      if (page == 1) {

        return_list[[2]]

      } else {

        page_url <- paste0(url_string, "&page=", page)

        page_return_json <- fetch_wb_url_content(url_string = page_url)
        page_return_list <- jsonlite::fromJSON(page_return_json,  flatten = TRUE)
        page_df <- page_return_list[[2]]

      }
    }
    ) # end lapply

    return_df <- do.call("rbind", page_list)

  } else { # only one page

    return_df <- return_list[[2]]

  }

  return_df$lastUpdated <- lastUpdated
  return_df

}




#' Title
#'
#' @param url_string
#' @param indicator
#'
#' @return
#'
#' @noRd
fetch_wb_url_content <- function(url_string, indicator) {

  indicator <- if_missing(indicator)

  # move this to data-raw eventually
  ua <- httr::user_agent("https://github.com/jpiburn/wbdata")

  # add api_token here if/when that is supported

  get_return <- httr::GET(url_string, ua)

  if (httr::http_error(get_return)) {

    error_status<- httr::http_status(get_return)

    stop(sprintf("World Bank API request failed for indicator %s\nmessage: %s\ncategory: %s\nreason: %s \nurl: %s",
                 indicator,
                 error_status$message,
                 error_status$category,
                 error_status$reason,
                 url_string),
         call. = FALSE)
  }

  if (httr::http_type(get_return) != "application/json") {
    stop("API call executed successfully, but did not return expected json format", call. = FALSE)
  }

  return_json <- httr::content(get_return, as = "text")

  return_json
}

