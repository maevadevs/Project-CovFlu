# This file is run only once at the start of the app

# install rsconnect for deploying app
# install.packages('rsconnect')

# Import all needed libraries
library(dplyr)
library(tidyverse)
library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dashboardthemes)
library(janitor)

csv_dest <- "./Project_CovFlu_App/data/" # Destination to dump cleaned data csv files

# Import all needed data files
covid19CaseSurveillance01 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-01.csv")
covid19CaseSurveillance02 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-02.csv")
covid19CaseSurveillance03 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-03.csv")
covid19CaseSurveillance04 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-04.csv")
covid19CaseSurveillance05 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-05.csv")
covid19CaseSurveillance06 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-06.csv")
covid19CaseSurveillance07 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-07.csv")
covid19CaseSurveillance08 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-08.csv")
covid19CaseSurveillance09 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-09.csv")
covid19CaseSurveillance10 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-10.csv")
covid19CaseSurveillance11 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-11.csv")
covid19CaseSurveillance12 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-12.csv")

list_of_dfs <- list(
  covid19CaseSurveillance01,
  covid19CaseSurveillance02,
  covid19CaseSurveillance03,
  covid19CaseSurveillance04,
  covid19CaseSurveillance05,
  covid19CaseSurveillance06,
  covid19CaseSurveillance07,
  covid19CaseSurveillance08,
  covid19CaseSurveillance09,
  covid19CaseSurveillance10,
  covid19CaseSurveillance11,
  covid19CaseSurveillance12
)

# covid19CaseSurveillance <- read.csv("data/covid19-case-surveillance-aggregated-01.csv") %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-02.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-03.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-04.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-05.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-06.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-07.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-08.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-09.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-10.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-11.csv")) %>%
#   bind_rows(read.csv("data/covid19-case-surveillance-aggregated-12.csv"))

index <- 1
# Select and Rename Needed Columns
for (df in list_of_dfs) {
  new_df <- df %>%
    select(
      -positive_specimen_earliest_date,
      -symptom_onset_date
    ) %>%
    rename(
      `Case Earliest Date`=case_earliest_date,
      `Confirmation Status`=current_status,
      `Sex`=sex,
      `Age Group`=age_group,
      `Hospitalized`=is_hospitalized,
      `ICU`=is_icu,
      `Death`=is_death,
      `With Underlying Conditions`=with_underlying_conditions,
      `Race`=race,
      `Ethnicity`=ethnicity
    )
  
  new_df %>%
    write.csv(
      row.names = FALSE,
      paste0(csv_dest, "covid19-case-surveillance-aggregated-", index, "-new.csv")
    )
  
  index <- index + 1
}

# covid19CaseSurveillance01 <- covid19CaseSurveillance01 %>%
#   select(
#     -positive_specimen_earliest_date,
#     -symptom_onset_date
#   ) %>%
#   rename(
#     `Case Earliest Date`=case_earliest_date,
#     `Confirmation Status`=current_status,
#     `Sex`=sex,
#     `Age Group`=age_group,
#     `Hospitalized`=is_hospitalized,
#     `ICU`=is_icu,
#     `Death`=is_death,
#     `With Underlying Conditions`=with_underlying_conditions,
#     `Race`=race,
#     `Ethnicity`=ethnicity
#   )
# 
# covid19CaseSurveillance01 %>%
#   write.csv(
#     row.names = FALSE,
#     paste0(csv_dest, "covid19-case-surveillance-aggregated-01.csv")
#   )

# covid19CaseSurveillance_status <- covid19CaseSurveillance %>%
#   group_by(`Confirmation Status`) %>% # Change this based on the view to check
#   summarise(
#     count=sum(n)
#   ) %>%
#   adorn_totals("row") %>%
#   View



# listx <- list(1,2,3)
# for (n in listx) {
#   print(n)
# }