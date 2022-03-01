query_db <- function(python_script) {
  out_file <- reticulate::py_run_file(python_script) %>% 
    reticulate::py_capture_output()
  out_file <- str_remove(out_file, "\n")
  return(out_file)
}


preprocess <- function(dat) {
  dat %>%
    # Drop 0-variance variables
    select(-prSurg,
           -NCH_PRMRY_PYR_CLM_PD_AMT,
           -ends_with("_COVERAGE")) %>%
    rowwise() %>%
    mutate(procedure = which.max(c_across(prNCP:prCL))) %>%
    ungroup() %>%
    mutate(
      procedure = case_when(
        procedure == 1 ~ "NCP",
        procedure == 2 ~ "CP",
        procedure == 3 ~ "NCL",
        TRUE ~ "CL"
      ) %>% 
        as_factor() %>% 
        fct_relevel("NCP", "CP", "NCL", "CL"),
      CCI_cat = case_when(
        CCI <= 1 ~ "0-1",
        CCI <= 4 ~ "2-4",
        TRUE ~ "5+"
      ) %>% 
        as_factor() %>% 
        fct_relevel("0-1","2-4","5+"),
      SEX_CODE = factor(SEX_CODE, labels = c("Male","Female")),
      RACE_CODE = if_else(RACE_CODE==1, "White", "Other") %>% 
        fct_relevel("Other", "White"),
      prMIS = if_else(prMIS==T, "MIS", "Open") %>% 
        as.factor()
    )
}

process_patient_characteristics <- function(dat) {
  
  dat %>% 
    select(
      procedure, 
      PRVDR_NUM,
      age, 
      SEX_CODE,
      RACE_CODE,
      CCI_cat,
      prMIS
    ) %>% 
    mutate(PRVDR_NUM = as.numeric(PRVDR_NUM),
           PRVDR_NUM = replace(PRVDR_NUM, 
                               which(is.na(PRVDR_NUM)), 
                               10^6+runif(1, min=1, max=100)),
           patients = 1) %>%
    relocate(patients) %>% 
    tbl_summary(
      by = procedure,
      type = list(SEX_CODE ~ "dichotomous",
                  RACE_CODE ~ "dichotomous"),
      value = list(SEX_CODE = "Male",
                   RACE_CODE = "White"),
      statistic = list(PRVDR_NUM ~ "{n_distinct}", 
                       age ~ "{mean} ({sd})",
                       patients ~ "{N}"),
      label = list(
        patients ~ "Patients",
        PRVDR_NUM ~ "Hospitals",
        age ~ "Age",
        SEX_CODE ~ "Male",
        RACE_CODE ~ "White",
        CCI_cat ~ "CCI",
        prMIS ~ "Surgical approach"
      )
    ) %>%  
    bold_labels() %>% 
    modify_header(update = all_stat_cols() ~ "**{level}**") %>% 
    add_stat_label() %>% 
    as_gt()

}

save_to_file <- function(tbl, name) {
  tbl %>% gtsave(filename = name, path = "out")
  return(paste("out", name, sep = "/"))
}

quantiles_of_spending <- function(dat) {
  # The authors state: "Unadjusted standardized Medicare payments for each group
  # were used to identify the highest and lowest quintiles of payments. Patients
  # within the highest and lowest quintiles of spending for each of the
  # procedure groups were identified. The most expensive 20% of patients were
  # defined as the super-utilizers." (p. 766)
  # 
  # I interpret the above as strata-specific quantiles.
  
  dat %>% 
    group_by(procedure) %>% 
    mutate(qamt = cut(CLM_PMT_AMT, 
                      breaks = quantile(CLM_PMT_AMT, probs = c(0, 1/5, 4/5, 1)),
                      labels = c("Bottom 20%", "Middle 60%", "Top 20%"))) %>% 
    filter(qamt != "Middle 60%") %>% 
    mutate(qamt = fct_drop(qamt)) %>% 
    select(
      qamt,
      procedure, 
      PRVDR_NUM,
      age, 
      SEX_CODE,
      RACE_CODE,
      CCI_cat,
      prMIS
    ) %>% 
    mutate(PRVDR_NUM = as.numeric(PRVDR_NUM),
           PRVDR_NUM = replace(PRVDR_NUM, 
                               which(is.na(PRVDR_NUM)), 
                               10^6+runif(1, min=1, max=100)),
           patients = 1) %>%
    relocate(patients) %>% 
    tbl_strata(
      strata = procedure,
      .tbl_fun = 
        ~ .x %>% 
        tbl_summary(
          by = qamt,
          type = list(SEX_CODE ~ "dichotomous",
                      RACE_CODE ~ "dichotomous"),
          value = list(SEX_CODE = "Male",
                       RACE_CODE = "White"),
          statistic = list(PRVDR_NUM ~ "{n_distinct}", 
                           age ~ "{mean} ({sd})",
                           patients ~ "{N}"),
          label = list(
            patients ~ "Patients",
            PRVDR_NUM ~ "Hospitals",
            age ~ "Age",
            SEX_CODE ~ "Male",
            RACE_CODE ~ "White",
            CCI_cat ~ "CCI",
            prMIS ~ "Surgical approach"
          )
        ) %>%  
        add_p(include = c(-patients,-PRVDR_NUM)) %>% 
        separate_p_footnotes() %>% 
        add_stat_label() %>% 
        bold_labels() %>% 
        modify_header(update = all_stat_cols() ~ "**{level}**")
    ) %>% 
    as_gt()
}
