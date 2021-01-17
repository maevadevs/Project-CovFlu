###
# - Fetch raw data files from ../raw-data
# - Apply processing and transformations
# - Export cleaned data into csv in the Project_CovFlu_App/data folder
###

# Imports
# -------

library(tidyverse)
library(dplyr)
library(tidyr)

# Setups and variables
# --------------------

source("./helper-functions.R") # Collection of helper functions
csv_dest <- "./Project_CovFlu_App/data/" # Destination to dump cleaned data csv files
csv_src <- "../raw-data/" # Because of the large size of the unprocessed our raw data sets, they are excluded from the project repo

# Raw Data Sources
# ----------------

covid19Racial <- read.csv(paste0(csv_src, "02-covidtracking.com/sources/covid-tracking-racial-data-tracker.csv"))

# Processing and Transformations
# ------------------------------

# Cases by Race
# *************
covid19Racial_cases_race <- covid19Racial %>% 
  select(Date:State, Cases_White:Cases_Unknown) %>%
  rename(
    Caucasian=Cases_White,
    African_American=Cases_Black,
    Latino=Cases_LatinX,
    Asian=Cases_Asian,
    AIAN=Cases_AIAN,
    NHPI=Cases_NHPI,
    Multiracial=Cases_Multiracial,
    Other=Cases_Other,
    Unknown=Cases_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Caucasian":"Unknown"),
    names_to="Race",
    values_to="Cases")

# Deaths by Race
# **************
covid19Racial_deaths_race <- covid19Racial %>% 
  select(Date:State, Deaths_White:Deaths_Unknown) %>%
  rename(
    Caucasian=Deaths_White,
    African_American=Deaths_Black,
    Latino=Deaths_LatinX,
    Asian=Deaths_Asian,
    AIAN=Deaths_AIAN,
    NHPI=Deaths_NHPI,
    Multiracial=Deaths_Multiracial,
    Other=Deaths_Other,
    Unknown=Deaths_Unknown
  )%>%
  # Pivot Longer
  tidyr::pivot_longer(c("Caucasian":"Unknown"),
                      names_to="Race",
                      values_to="Deaths")

# Hospitalizations by Race
# ************************
covid19Racial_hosp_race <- covid19Racial %>% 
  select(Date:State, Hosp_White:Hosp_Unknown) %>%
  rename(
    Caucasian=Hosp_White,
    African_American=Hosp_Black,
    Latino=Hosp_LatinX,
    Asian=Hosp_Asian,
    AIAN=Hosp_AIAN,
    NHPI=Hosp_NHPI,
    Multiracial=Hosp_Multiracial,
    Other=Hosp_Other,
    Unknown=Hosp_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Caucasian":"Unknown"),
                      names_to="Race",
                      values_to="Hospitalizations")

# Tests by Race
# *************
covid19Racial_tests_race <- covid19Racial %>% 
  select(Date:State, Tests_White:Tests_Unknown) %>%
  rename(
    Caucasian=Tests_White,
    African_American=Tests_Black,
    Latino=Tests_LatinX,
    Asian=Tests_Asian,
    AIAN=Tests_AIAN,
    NHPI=Tests_NHPI,
    Multiracial=Tests_Multiracial,
    Other=Tests_Other,
    Unknown=Tests_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Caucasian":"Unknown"),
                      names_to="Race",
                      values_to="Tests")

# Cases by Ethnicity
# ******************
covid19Racial_cases_ethnicity <- covid19Racial %>% 
  select(Date:State, Cases_Ethnicity_Hispanic:Cases_Ethnicity_Unknown) %>%
  rename(
    Hispanic=Cases_Ethnicity_Hispanic,
    NonHispanic=Cases_Ethnicity_NonHispanic,
    Unknown=Cases_Ethnicity_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Hispanic":"Unknown"),
                      names_to="Ethnicity",
                      values_to="Cases")

# Deaths by Ethnicity
# *******************
covid19Racial_deaths_ethnicity <- covid19Racial %>% 
  select(Date:State, Deaths_Ethnicity_Hispanic:Deaths_Ethnicity_Unknown) %>%
  rename(
    Hispanic=Deaths_Ethnicity_Hispanic,
    NonHispanic=Deaths_Ethnicity_NonHispanic,
    Unknown=Deaths_Ethnicity_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Hispanic":"Unknown"),
                      names_to="Ethnicity",
                      values_to="Deaths")

# Hospitcalizations by Ethnicity
# ******************************
covid19Racial_hosp_ethnicity <- covid19Racial %>% 
  select(Date:State, Hosp_Ethnicity_Hispanic:Hosp_Ethnicity_Unknown) %>%
  rename(
    Hispanic=Hosp_Ethnicity_Hispanic,
    NonHispanic=Hosp_Ethnicity_NonHispanic,
    Unknown=Hosp_Ethnicity_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Hispanic":"Unknown"),
                      names_to="Ethnicity",
                      values_to="Hospitalizations")
  
# Tests by Ethnicity
# ******************
covid19Racial_tests_ethnicity <- covid19Racial %>% 
  select(Date:State, Tests_Ethnicity_Hispanic:Tests_Ethnicity_Unknown) %>%
  rename(
    Hispanic=Tests_Ethnicity_Hispanic,
    NonHispanic=Tests_Ethnicity_NonHispanic,
    Unknown=Tests_Ethnicity_Unknown
  ) %>%
  # Pivot Longer
  tidyr::pivot_longer(c("Hispanic":"Unknown"),
                      names_to="Ethnicity",
                      values_to="Tests")

# Join all Race-based DFs
# ***********************
covid19Races_final <- covid19Racial_cases_race %>%
  full_join(covid19Racial_deaths_race, by=c("Date", "State", "Race")) %>%
  full_join(covid19Racial_hosp_race, by=c("Date", "State", "Race")) %>%
  full_join(covid19Racial_tests_race, by=c("Date", "State", "Race")) %>%
  # We are only looking at cases up to 12/31/2020
  filter(as.Date(Date) <= as.Date('2020-12-31'))

# Join all Ethnicity-based DFs
# ****************************
covid19Ethnicity_final <- covid19Racial_cases_ethnicity %>%
  full_join(covid19Racial_deaths_ethnicity, by=c("Date", "State", "Ethnicity")) %>%
  full_join(covid19Racial_hosp_ethnicity, by=c("Date", "State", "Ethnicity")) %>%
  full_join(covid19Racial_tests_ethnicity, by=c("Date", "State", "Ethnicity")) %>%
  # We are only looking at cases up to 12/31/2020
  filter(as.Date(Date) <= as.Date('2020-12-31'))

# Export the final Datasets
# *************************
covid19Races_final %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covidtracking-races-timeseries-by-state.csv")
  )

covid19Ethnicity_final %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covidtracking-ethnicity-timeseries-by-state.csv")
  )
