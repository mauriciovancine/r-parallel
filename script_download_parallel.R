# packages
library(tidyverse)
library(rvest)
library(parallelly)
library(doParallel)
library(foreach)

# options
options(timeout = 1e6) # aumenta o tempo de download

# download worldclim --------------------------------------------------

# url
urls <- "https://www.worldclim.org/data/worldclim21.html" %>% 
    rvest::read_html() %>% 
    rvest::html_nodes("a") %>% 
    rvest::html_attr("href") %>% 
    stringr::str_subset(".zip")
urls

# files
destfiles <- basename(urls)
destfiles

# download
doParallel::registerDoParallel(parallelly::availableCores(omit = 2))

foreach::foreach(i=1:length(urls)) %dopar% {
    
    download.file(url = urls[i], destfile = paste0("~/Downloads/", destfiles[i]), mode = "wb")
    
}



# end ---------------------------------------------------------------------
