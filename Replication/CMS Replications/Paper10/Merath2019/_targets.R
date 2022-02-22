library(targets)
library(tarchetypes)

source("src/functions.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("dplyr", "DBI"))

list(
  tar_target( my_query, "src/cms_query.sql", format = "file" )
)
