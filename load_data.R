pacman::p_load(dplyr)


### CIERRE INVERSIONES

query <- "https://files.jlh.work/CARE/CIERRE_INVERSIONES.csv"
url_encoded <- utils::URLencode(query, reserved = F)
url <- url_encoded
destfile <- here::here("input",glue::glue("CIERRE_INVERSIONES.csv"))
curl::curl_download(url, destfile)

dt_cierre <- rio::import(destfile)
