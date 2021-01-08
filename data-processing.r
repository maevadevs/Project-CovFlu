###
# - Fetch raw data files from ../raw-data
# - Apply processing and transformations
# - Export cleaned data into csv in the Project_CovFlu_App/data folder
###

# Imports
# -------

library(tidyverse)
library(dplyr)
library(janitor) # For adorn_totals()

# Setups and variables
# --------------------

source("./helper-functions.R") # Collection of helper functions
csv_dest <- "./Project_CovFlu_App/data/" # Destination to dump cleaned data csv files

# Processing and Transformations
# ------------------------------




# Export cleaned data
# -------------------
# Make sure to change some_df into the name of the df to export

some_df %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "filename.csv")
  )
