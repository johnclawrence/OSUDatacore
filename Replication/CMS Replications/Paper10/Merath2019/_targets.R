library(targets)
library(tarchetypes)

source("src/functions.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "gtsummary", "gt"))

list(
  tar_target(my_query, "src/cms_query_dev09v2.py", format = "file"),
  tar_target(query_results, query_db(my_query), format = "file"),
  tar_target(dat_raw, read_csv(query_results) %>% select(-1)),
  tar_target(dat_clean, preprocess(dat_raw)),
  tar_target(table1, process_patient_characteristics(dat_clean)),
  tar_target(table1_html, save_to_file(table1,"table1.html"), format="file"),
  tar_target(table3, quantiles_of_spending(dat_clean)),
  tar_target(table3_html, save_to_file(table3,"table3.html"), format="file")
)
