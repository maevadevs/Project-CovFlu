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
library(DT)
library(dashboardthemes)
library(janitor)
library(formattable)

# Global variables
CustomPlotBackgroundColor <- "#2D3741"

# Import all needed data files
covid19CaseSurv_all <- read.csv("data/covid19-case-surv-aggregated-all.csv")
covid19CaseSurv01 <- read.csv("data/covid19-case-surv-aggregated-01.csv")
covid19CaseSurv02 <- read.csv("data/covid19-case-surv-aggregated-02.csv")
covid19CaseSurv03 <- read.csv("data/covid19-case-surv-aggregated-03.csv")
covid19CaseSurv04 <- read.csv("data/covid19-case-surv-aggregated-04.csv")
covid19CaseSurv05 <- read.csv("data/covid19-case-surv-aggregated-05.csv")
covid19CaseSurv06 <- read.csv("data/covid19-case-surv-aggregated-06.csv")
covid19CaseSurv07 <- read.csv("data/covid19-case-surv-aggregated-07.csv")
covid19CaseSurv08 <- read.csv("data/covid19-case-surv-aggregated-08.csv")
covid19CaseSurv09 <- read.csv("data/covid19-case-surv-aggregated-09.csv")
covid19CaseSurv10 <- read.csv("data/covid19-case-surv-aggregated-10.csv")
covid19CaseSurv11 <- read.csv("data/covid19-case-surv-aggregated-11.csv")
covid19CaseSurv12 <- read.csv("data/covid19-case-surv-aggregated-12.csv")

fluDeaths2019Monthly <- read.csv("data/deaths-by-influenza-and-pneumonia-2019-monthly.csv")

# Variables from covid19CaseSurv_all
# All the datasets have the same columns
# Used for dropdown select in ui

covid19CaseSurv_allcols <- covid19CaseSurv_all %>%
  colnames()

Covid19Dimensions <- covid19CaseSurv_allcols[c(2:6)]

# Case Earliest Date Range
covid19CaseSurv_mindate <- covid19CaseSurv_all$Case.Earliest.Date %>% min()
covid19CaseSurv_maxdate <- covid19CaseSurv_all$Case.Earliest.Date %>% max()

# List of months to filter data sets by
month_name <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

# Covid-19: Confirmation Status Distribution
# covid19CaseSurveillance_status <- covid19CaseSurveillance %>%
#   group_by(`Confirmation Status`) %>% # Change this based on the view to check
#   summarise(
#     count=sum(n)
#   ) %>%
#   adorn_totals("row")



# Helper Functions
# ----------------

extract_columns <- function(data, desired_columns) {
  extracted_data <- data %>%
    select_(.dots = desired_columns)
  return(extracted_data)
}