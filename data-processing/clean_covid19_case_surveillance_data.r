###
# - Fetch raw data files from ../raw-data
# - Apply processing and transformations
# - Export cleaned data into csv in the Project_CovFlu_App/data folder
###

# Imports
# -------

library(tidyverse)
library(dplyr)
library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dashboardthemes)
library(janitor)

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
  # Remove unneeded column
  select(
    -cdc_report_dt,# Deprecated, use new cdc_case_earliest_dt instead
    -pos_spec_dt,
    -onset_dt,
    -medcond_yn) %>% 
  # Only keep the range for the age group
  separate(col = age_group,
           into = c("Age.Group", "temp"),
           sep = " Y",
           remove = TRUE) %>%
  # Remove unneeded column
  select(-temp) %>% # temporary column from splitting age_group
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
           into = c("Race", "Ethnicity"),
           sep = ", ",
           remove = TRUE) %>%
  # Remove unneeded columns
  select(
    -race_ethnicity_combined, # Left-over from cleaning race and ethnicity
    -Ethnicity # We are only going to focus on Race only
  ) %>% 
  # Rename the columns appropriately
  rename(Case.Earliest.Date = cdc_case_earliest_dt,
         Confirmation.Status = current_status,
         Gender = sex,
         Hospitalization = hosp_yn,
         ICU = icu_yn,
         Death = death_yn)

# Export cleaned data
# -------------------

# Exporting this dataset result in a massive file
# We are going to aggregate

df_to_export <- clean_df %>%
  select(Case.Earliest.Date:Race) %>%
  group_by(Case.Earliest.Date, 
           Confirmation.Status,
           Gender,
           Age.Group,
           Hospitalization,
           ICU,
           Death,
           Race) %>%
  summarise(Count = n()) %>%
  ungroup()

# Fix some values for Race
df_to_export$Race[df_to_export$Race == "American Indian/Alaska Native"] <- "AIAN"
df_to_export$Race[df_to_export$Race == "Black"] <- "African American"
df_to_export$Race[df_to_export$Race == "Hispanic/Latino"] <- "Latino"
df_to_export$Race[df_to_export$Race == "Multiple/Other"] <- "Multiracial/Other"
df_to_export$Race[df_to_export$Race == "Native Hawaiian/Other Pacific Islander"] <- "NHPI"
df_to_export$Race[df_to_export$Race == "White"] <- "Caucasian"










# Now Exporting
# *************
# Split into monthly files to meet requirement <100Mb

# January
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-01-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-01-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-01.csv")
  )

# February
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-02-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-02-29"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-02.csv")
  )

# March
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-03-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-03-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-03.csv")
  )

# April
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-04-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-04-30"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-04.csv")
  )

# Mai
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-05-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-05-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-05.csv")
  )

# June
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-06-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-06-30"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-06.csv")
  )

# July
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-07-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-07-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-07.csv")
  )

# August
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-08-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-08-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-08.csv")
  )

# September
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-09-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-09-30"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-09.csv")
  )

# October
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-10-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-10-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-10.csv")
  )

# November
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-11-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-11-30"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-11.csv")
  )

# December
df_to_export %>%
  select(Case.Earliest.Date:Count) %>%
  filter(as.Date(Case.Earliest.Date) >= as.Date(str_interp("2020-12-01")) & as.Date(Case.Earliest.Date) <= as.Date(str_interp("2020-12-31"))) %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surv-aggregated-12.csv")
  )
