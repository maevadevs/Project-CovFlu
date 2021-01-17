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

# Import all needed data files
covid19CaseSurveillance01 <- read.csv("data/covid19-case-surveillance-aggregated-1-new.csv")
covid19CaseSurveillance02 <- read.csv("data/covid19-case-surveillance-aggregated-2-new.csv")
covid19CaseSurveillance03 <- read.csv("data/covid19-case-surveillance-aggregated-3-new.csv")
covid19CaseSurveillance04 <- read.csv("data/covid19-case-surveillance-aggregated-4-new.csv")
covid19CaseSurveillance05 <- read.csv("data/covid19-case-surveillance-aggregated-5-new.csv")
covid19CaseSurveillance06 <- read.csv("data/covid19-case-surveillance-aggregated-6-new.csv")
covid19CaseSurveillance07 <- read.csv("data/covid19-case-surveillance-aggregated-7-new.csv")
covid19CaseSurveillance08 <- read.csv("data/covid19-case-surveillance-aggregated-8-new.csv")
covid19CaseSurveillance09 <- read.csv("data/covid19-case-surveillance-aggregated-9-new.csv")
covid19CaseSurveillance10 <- read.csv("data/covid19-case-surveillance-aggregated-10-new.csv")
covid19CaseSurveillance11 <- read.csv("data/covid19-case-surveillance-aggregated-11-new.csv")
covid19CaseSurveillance12 <- read.csv("data/covid19-case-surveillance-aggregated-12-new.csv")

# covid19CaseSurveillance_status <- covid19CaseSurveillance %>%
#   group_by(`Confirmation Status`) %>% # Change this based on the view to check
#   summarise(
#     count=sum(n)
#   ) %>%
#   adorn_totals("row") %>%
#   View
