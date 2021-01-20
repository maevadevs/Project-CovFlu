# This file is run only once at the start of the app



# install rsconnect for deploying app
# -----------------------------------

# install.packages('rsconnect')



# Libraries
# ---------

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
# ----------------

# CustomPlotBackgroundColor <- "#2D3741"



# Data Files
# ----------

# covid19CaseSurv_all <- read.csv("data/covid19-case-surv-aggregated-all.csv")

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

# Covid19 cases count in 2020: 1/1/2020 - 12/31/2020
# --------------------------------------------------

covid19TotalCasesCountIn2020 <- sum(covid19CaseSurv_all$Count)
fluTotalCasesCount2019 <- sum(fluDeaths2019Monthly$Death, na.rm = TRUE)

# Variables from covid19CaseSurv
# ------------------------------
# All the datasets have the same columns
# Used for dropdown select in ui

covid19CaseSurv_allcols <- covid19CaseSurv01 %>% colnames()

# covid19CaseSurv_allcols:
# [1] "Case.Earliest.Date"  "Confirmation.Status" "Gender"             
# [4] "Age.Group"           "Hospitalization"     "ICU"                
# [7] "Death"               "Race"                "Count"

Covid19Dimensions <- covid19CaseSurv_allcols[c(2:8)]

# Case Earliest Date Range

covid19CaseSurv_mindate <- covid19CaseSurv01$Case.Earliest.Date %>% min()
covid19CaseSurv_maxdate <- covid19CaseSurv12$Case.Earliest.Date %>% max()

# List of months to filter data sets by

month_name <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")



# Helper Functions
# ----------------

# Function: Allow to select a list of wanted columns from a dataframe
# Return the selected columns as a dataframe

extract_columns <- function(data, desired_columns) {
  extracted_data <- data %>%
    select({{ desired_columns }})
  return(extracted_data)
}



# Dplyr Function Steps: 
# group_by, summarise, and generate percent column

covid_group_summarise_mutate <- function(df, group_arrange_var, summarise_var) {
  df %>%
    group_by({{ group_arrange_var }}) %>%
    summarise(
      Count=sum({{ summarise_var }})
    ) %>%
    ungroup() %>%
    mutate(
      Percent=round(Count / sum(Count) * 100, 2)
    ) %>%
    arrange({{ group_arrange_var }})
}



# Dplyr Function Steps: 
# Allow to filter by, group_by, summarise, and generate percent column

covid_filter_group_summarise_mutate <- function(df, filter_var, filter_val, group_arrange_var, summarise_var) {
  df %>%
      filter({{ filter_var }} == filter_val) %>%
      group_by({{ group_arrange_var }}) %>%
      summarise(
        Count=sum({{ summarise_var }})
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange({{ group_arrange_var }})
}



# Dplyr Function Steps:
# Allow to group_by, summarise, and generate percent column
# For Flu data

flu_group_summarise_mutate <- function(df, group_arrange_var, summarise_var) {
  df %>%
    group_by({{ group_arrange_var }}) %>%
    summarise(
      Count=sum({{ summarise_var }}, na.rm = TRUE)
    ) %>%
    ungroup() %>%
    mutate(
      Percent=round(Count / sum(Count) * 100, 2)
    ) %>%
    arrange({{ group_arrange_var }})
}



# Dplyr Function Steps:
# Add plot layout

add_plot_layout <- function(plot, title) {
  plot %>%
    layout(
      yaxis=list(
        title="",
        zerolinecolor = toRGB("#cdcdcd"),
        zerolinewidth = 1,
        linecolor = toRGB("#cdcdcd"),
        linewidth = 1,
        tickfont=list(color=c("#cdcdcd")),
        titlefont = list(color=c("#cdcdcd")),
        gridcolor = toRGB("gray50"),
        gridwidth = 1
      ),
      xaxis=list(
        title=title, 
        tickangle=-45,
        zerolinecolor = toRGB("#cdcdcd"),
        zerolinewidth = 1,
        linecolor = toRGB("#cdcdcd"),
        linewidth = 1,
        tickfont=list(color=c("#cdcdcd")),
        titlefont = list(color=c("#cdcdcd"))
      ),
      # showlegend=FALSE,
      legend = list(
        orientation = "v", # show entries horizontally
        # xanchor = "center", # use center of legend as anchor
        # x = 0.5,
        font = list(color=c("#cdcdcd"))
      ),
      plot_bgcolor=toRGB("#2d3741"), # Customize the background color of the plot
      paper_bgcolor=toRGB("#2d3741") # Customize the background color of the margin
    )
}