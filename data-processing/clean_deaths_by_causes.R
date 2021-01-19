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

deathCountsCauses <- read.csv(paste0(csv_src, "04-data.cdc.gov/deaths/Monthly provisional counts of deaths by age group, sex, and race-ethnicity for select causes of death.csv"))

# Processing and Transformations
# ------------------------------

clean_df <- deathCountsCauses %>% 
  # Focus only on 2019 data for Flu
  filter(Date.Of.Death.Year == 2019) %>%
  # Only keep needed columns
  select(
    Date.Of.Death.Year:AgeGroup,
    Influenza.and.pneumonia..J09.J18.) %>% 
  # Only keep the range for the age group
  separate(col = AgeGroup,
           into = c("Age.Group", "temp"),
           sep = " y",
           remove = TRUE) %>%
  # Only keep the spelled out Sex and rename column to Gender
  separate(col = Sex,
           into = c("Gender", "temp"),
           sep = " ",
           remove = TRUE) %>%
  # Remove unneeded column
  select(-temp) %>% # temporary column from splitting Sex
  # Normalize race and ethnicity values
  mutate(
    clean_ethnicity_race = case_when(
      Race.Ethnicity == "Hispanic" ~ "x,Latino",
      Race.Ethnicity == "Non-Hispanic American Indian or Alaska Native" ~ "x,AIAN",
      Race.Ethnicity == "Non-Hispanic Asian" ~ "x,Asian",
      Race.Ethnicity == "Non-Hispanic Black" ~ "x,Black",
      Race.Ethnicity == "Non-Hispanic White" ~ "x,White",
      Race.Ethnicity == "Other" ~ "x,Other",
      TRUE ~ as.character(Race.Ethnicity)
    )
  ) %>%
  # Split combined race and ethnicity values to separate
  separate(col = clean_ethnicity_race,
           into = c("Ethnicity", "Race"),
           sep = ",",
           remove = TRUE) %>%
  # Keep only Race
  select(-Ethnicity, -Race.Ethnicity) %>%
  # Rename the columns appropriately
  rename(Death.Year = Date.Of.Death.Year,
         Death.Month = Date.Of.Death.Month,
         Death = Influenza.and.pneumonia..J09.J18.)

# Fix some values for Race
clean_df$Race[clean_df$Race == "Black"] <- "African American"
clean_df$Race[clean_df$Race == "Other"] <- "Multiracial/Other"
clean_df$Race[clean_df$Race == "White"] <- "Caucasian"

# Fix some values for Age.Group
clean_df$Age.Group[clean_df$Age.Group == "5-14"] <- "05-14"
clean_df$Age.Group[clean_df$Age.Group == "85"] <- "85+"

# Rename Months
clean_df$Death.Month[clean_df$Death.Month == 1] <- "January"
clean_df$Death.Month[clean_df$Death.Month == 2] <- "February"
clean_df$Death.Month[clean_df$Death.Month == 3] <- "March"
clean_df$Death.Month[clean_df$Death.Month == 4] <- "April"
clean_df$Death.Month[clean_df$Death.Month == 5] <- "May"
clean_df$Death.Month[clean_df$Death.Month == 6] <- "June"
clean_df$Death.Month[clean_df$Death.Month == 7] <- "July"
clean_df$Death.Month[clean_df$Death.Month == 8] <- "August"
clean_df$Death.Month[clean_df$Death.Month == 9] <- "September"
clean_df$Death.Month[clean_df$Death.Month == 10] <- "October"
clean_df$Death.Month[clean_df$Death.Month == 11] <- "November"
clean_df$Death.Month[clean_df$Death.Month == 12] <- "December"

# Export the final Dataset
# ************************
clean_df %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "deaths-by-influenza-and-pneumonia-2019-monthly.csv")
  )






