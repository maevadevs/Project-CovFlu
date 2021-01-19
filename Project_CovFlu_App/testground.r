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
# covid19CaseSurv <- read.csv("data/More_Exploration/covid19-case-surv-aggregated-all.csv")
covid19CaseSurv01 <- read.csv("data/covid19-case-surv-aggregated-01.csv")
# covid19CaseSurveillance02 <- read.csv("data/covid19-case-surveillance-aggregated-2-new.csv")
# covid19CaseSurveillance03 <- read.csv("data/covid19-case-surveillance-aggregated-3-new.csv")
# covid19CaseSurveillance04 <- read.csv("data/covid19-case-surveillance-aggregated-4-new.csv")
# covid19CaseSurveillance05 <- read.csv("data/covid19-case-surveillance-aggregated-5-new.csv")
# covid19CaseSurveillance06 <- read.csv("data/covid19-case-surveillance-aggregated-6-new.csv")
# covid19CaseSurveillance07 <- read.csv("data/covid19-case-surveillance-aggregated-7-new.csv")
# covid19CaseSurveillance08 <- read.csv("data/covid19-case-surveillance-aggregated-8-new.csv")
# covid19CaseSurveillance09 <- read.csv("data/covid19-case-surveillance-aggregated-9-new.csv")
# covid19CaseSurveillance10 <- read.csv("data/covid19-case-surveillance-aggregated-10-new.csv")
# covid19CaseSurveillance11 <- read.csv("data/covid19-case-surveillance-aggregated-11-new.csv")
# covid19CaseSurveillance12 <- read.csv("data/covid19-case-surveillance-aggregated-12-new.csv")

# covid19CaseSurveillance_status <- covid19CaseSurveillance %>%
#   group_by(`Confirmation Status`) %>% # Change this based on the view to check
#   summarise(
#     count=sum(n)
#   ) %>%
#   adorn_totals("row") %>%
#   View

# covid19CaseSurv_allcols <- covid19CaseSurv %>%
#   colnames()
# 
# covid19CaseSurv %>%
#   filter(Death == "Yes") %>%
#   View

all_cases_data <- covid19CaseSurv01 %>%
  group_by(Age.Group) %>%
  summarise(
    Count=sum(Count)
  ) %>%
  ungroup() %>%
  mutate(
    Percent=Count / sum(Count) * 100
  ) %>%
  arrange(Age.Group)

# All confirmed cases grouped by Age
confirmed_cases_data <- covid19CaseSurv01 %>%
  filter(Confirmation.Status == "Laboratory-confirmed case") %>%
  group_by(Age.Group) %>%
  summarise(
    Count=sum(Count)
  ) %>%
  ungroup() %>%
  mutate(
    Percent=Count / sum(Count) * 100
  ) %>%
  arrange(Age.Group)

# All Hospitalization cases grouped by Age
hospitalization_cases_data <- covid19CaseSurv01 %>%
  filter(Hospitalization == "Yes") %>%
  group_by(Age.Group) %>%
  summarise(
    Count=sum(Count)
  ) %>%
  ungroup() %>%
  mutate(
    Percent=Count / sum(Count) * 100
  ) %>%
  arrange(Age.Group)

# All ICU cases grouped by Age
icu_cases_data <- covid19CaseSurv01 %>%
  filter(ICU == "Yes") %>%
  group_by(Age.Group) %>%
  summarise(
    Count=sum(Count)
  ) %>%
  ungroup() %>%
  mutate(
    Percent=Count / sum(Count) * 100
  ) %>%
  arrange(Age.Group)

# All Death cases grouped by Age
death_cases_data <- covid19CaseSurv01 %>%
  filter(Death == "Yes") %>%
  group_by(Age.Group) %>%
  summarise(
    Count=sum(Count)
  ) %>%
  ungroup() %>%
  mutate(
    Percent=Count / sum(Count) * 100
  ) %>%
  arrange(Age.Group)


plot <- plot_ly()

plot <- plot %>%
  add_bars(
    all_cases_data,
    x=~Age.Group, 
    y=~Count,
    name='Cases',
    hoverinfo="text",
    text=~paste0(
      "Age Group: ", Age.Group,
      "<br>Count: ", comma(Count, format="d"),
      "<br>Percent: ", round(Percent, 2), "%"
    )
  )

plot <- plot %>%
  add_bars(
    death_cases_data,
    x=~Age.Group, 
    y=~Count,
    name='Death Cases',
    hoverinfo="text",
    text=~paste0(
      "Age Group: ", Age.Group,
      "<br>Count: ", comma(Count, format="d"),
      "<br>Percent: ", round(Percent, 2), "%"
    )
  ) %>%
  layout(
    yaxis=list(
      title="Count",
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
      title="Age Group", 
      tickangle=-45,
      zerolinecolor = toRGB("#cdcdcd"),
      zerolinewidth = 1,
      linecolor = toRGB("#cdcdcd"),
      linewidth = 1,
      tickfont=list(color=c("#cdcdcd")),
      titlefont = list(color=c("#cdcdcd"))
    ),
    showlegend=FALSE,
    plot_bgcolor=toRGB("#2d3741"), # Customize the background color of the plot
    paper_bgcolor=toRGB("#2d3741") # Customize the background color of the margin
  )



fluDeaths2019Monthly %>%
  filter(Death.Month == "January") %>%
  group_by(Age.Group) %>%
  summarise(
    Count=sum(Death, na.rm = TRUE)
  ) %>%
  ungroup() %>%
  mutate(
    Percent=round(Count / sum(Count) * 100, 2)
  ) %>%
  arrange(Age.Group) %>%
  View()
