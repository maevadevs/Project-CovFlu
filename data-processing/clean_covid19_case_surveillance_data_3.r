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
covid19CaseSurveillance01 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-1-new.csv")
covid19CaseSurveillance02 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-2-new.csv")
covid19CaseSurveillance03 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-3-new.csv")
covid19CaseSurveillance04 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-4-new.csv")
covid19CaseSurveillance05 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-5-new.csv")
covid19CaseSurveillance06 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-6-new.csv")
covid19CaseSurveillance07 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-7-new.csv")
covid19CaseSurveillance08 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-8-new.csv")
covid19CaseSurveillance09 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-9-new.csv")
covid19CaseSurveillance10 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-10-new.csv")
covid19CaseSurveillance11 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-11-new.csv")
covid19CaseSurveillance12 <- read.csv("Project_covFlu_App/data/covid19-case-surveillance-aggregated-12-new.csv")

list_of_dfs <- list(
  # covid19CaseSurveillance01,
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

index <- 1
final_df <- covid19CaseSurveillance01 %>%
  select(
    -Hospitalized,
    -ICU,
    -Death,
    -With.Underlying.Conditions
  ) %>%
  group_by(
    Case.Earliest.Date,
    Confirmation.Status,
    Sex,
    Age.Group,
    Race,
    Ethnicity
  ) %>%
  summarise(
    Count=sum(n)
  ) %>%
  ungroup()

# Select and Rename Needed Columns
for (df in list_of_dfs) {
  new_df <- df %>%
    select(
      -Hospitalized,
      -ICU,
      -Death,
      -With.Underlying.Conditions
    ) %>%
    group_by(
      Case.Earliest.Date,
      Confirmation.Status,
      Sex,
      Age.Group,
      Race,
      Ethnicity
    ) %>%
    summarise(
      Count=sum(n)
    ) %>%
    ungroup()
  
  # Bind into final_df
  final_df <- final_df %>%
    bind_rows(new_df)
  
  index <- index + 1
}

final_df %>%
  write.csv(
    row.names = FALSE,
    paste0(csv_dest, "covid19-case-surveillance-aggregated-all.csv")
  )

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