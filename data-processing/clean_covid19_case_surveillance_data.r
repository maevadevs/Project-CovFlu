###
# - Fetch raw data files from ../raw-data
# - Apply processing and transformations
# - Export cleaned data into csv in the Project_CovFlu_App/data folder
###

# Imports
# -------

library(tidyverse)

# Setups and variables
# --------------------

source("./helper-functions.R") # Collection of helper functions
csv_dest <- "./Project_CovFlu_App/data/" # Destination to dump cleaned data csv files
csv_src <- "../raw-data/" # Because of the large size of the unprocessed our raw data sets, they are excluded from the project repo

# Raw Data Sources
# ----------------

covid19Surveillance <- read.csv(paste0(csv_src, "04-data.cdc.gov/deaths/COVID-19 Case Surveillance Public Use Data.csv"))

# Processing and Transformations
# ------------------------------

clean_df <- covid19Surveillance %>% 
  # Rename the columns appropriately
  rename(case_earliest_date = cdc_case_earliest_dt,
         positive_specimen_earliest_date = pos_spec_dt,
         symptom_onset_date = onset_dt,
         is_hospitalized = hosp_yn,
         is_icu = icu_yn,
         is_death = death_yn,
         with_underlying_conditions = medcond_yn) %>%
  # Only keep the range for the age group
  separate(col = age_group,
           into = c("age_group", "temp"),
           sep = " Y",
           remove = TRUE) %>%
  # Normalize race and ethnicity values
  mutate(
    clean_race_ethnicity = case_when(
      race_ethnicity_combined == "Hispanic/Latino" ~ "Hispanic/Latino, Hispanic",
      race_ethnicity_combined == "Missing" ~ "Missing, Missing",
      race_ethnicity_combined == "Unknown" ~ "Unknown, Unknown",
      TRUE ~ as.character(race_ethnicity_combined)
    )
  ) %>%
  # Split combined race and ethnicity values to separate
  separate(col = clean_race_ethnicity,
           into = c("race", "ethnicity"),
           sep = ", ",
           remove = TRUE) %>%
  # Remove unneeded column
  select(-cdc_report_dt) %>% # Deprecated, use new cdc_case_earliest_dt instead
  select(-temp) %>% # temporary column from splitting age_group
  select(-race_ethnicity_combined) # Left-over from cleaning race and ethnicity

# Export cleaned data
# -------------------

# Exporting this dataset result in a massive file
# We are going to aggregate

df_to_export <- clean_df %>%
  select(case_earliest_date:ethnicity) %>%
  group_by(case_earliest_date, 
           positive_specimen_earliest_date,
           symptom_onset_date,
           current_status,
           sex,
           age_group,
           is_hospitalized,
           is_icu,
           is_death,
           with_underlying_conditions,
           race,
           ethnicity) %>%
  summarise(n = n()) %>%
  ungroup()

# Now Exporting
# Split into 4 files to meet requirement <100Mb

df_to_export_jan <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-01-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-01-31")))

df_to_export_feb <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-02-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-02-29")))

df_to_export_mar <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-03-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-03-31")))

df_to_export_apr <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-04-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-04-30")))

df_to_export_may <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-05-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-05-31")))

df_to_export_jun <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-06-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-06-30")))

df_to_export_jul <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-07-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-07-31")))

df_to_export_aug <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-08-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-08-31")))

df_to_export_sep <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-09-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-09-30")))

df_to_export_oct <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-10-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-10-31")))

df_to_export_nov <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-11-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-11-30")))

df_to_export_dec <- df_to_export %>%
  select(case_earliest_date:n) %>%
  filter(as.Date(case_earliest_date) >= as.Date(str_interp("2020-12-01")) & as.Date(case_earliest_date) <= as.Date(str_interp("2020-12-31")))

# Export each month-basis subset
df_to_export_jan %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-01.csv")
  )

df_to_export_feb %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-02.csv")
  )

df_to_export_mar %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-03.csv")
  )

df_to_export_apr %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-04.csv")
  )

df_to_export_may %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-05.csv")
  )

df_to_export_jun %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-06.csv")
  )

df_to_export_jul %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-07.csv")
  )

df_to_export_aug %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-08.csv")
  )

df_to_export_sep %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-09.csv")
  )

df_to_export_oct %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-10.csv")
  )

df_to_export_nov %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-11.csv")
  )

df_to_export_dec %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-12.csv")
  )
