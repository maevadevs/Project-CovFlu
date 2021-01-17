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

covid19County <- read.csv(paste0(csv_src, "01-nytimes/sources/nytimes-time-series-covid-cases-county.csv"))

# Processing and Transformations
# ------------------------------

covid19County_final <- covid19County %>% 
  # Rename Columns
  rename(
    Date=date,
    County=county,
    State=state,
    FIPS=fips,
    Cases=cases,
    Deaths=deaths
  ) %>%
  # We are only looking at cases up to 12/31/2020
  filter(as.Date(Date, '%m/%d/%Y') <= as.Date('2020-12-31'))

# Export the final Datasets
# *************************
covid19County_final %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "nytimes-time-series-covid-cases-county.csv")
  )