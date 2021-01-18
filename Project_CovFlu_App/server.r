# All libraries are imported in global.R

# Define the Application server logic
shinyServer(function(input, output) {
  
  # Reactive: Filtering the covid-19 data based on the widget input
  # covid19CaseSurv_filtered <- reactive({
  #   covid19CaseSurv %>%
  #     # Filter based on the Case Ealiest Date
  #     filter(Case.Earliest.Date >= as.Date(format(input$covid19CaseDateRange[1]))) %>%
  #     filter(Case.Earliest.Date <= as.Date(format(input$covid19CaseDateRange[2]))) %>%
  #     # Select only the variables based on the selected inputs
  #     extract_columns(input$covid19Dimensions) %>%
  #     data.frame()
  # })
  
  # Reactive: Filtering the covid-19 data based on the widget input
  covid19CaseSurv_month_filtered <- reactive({
    month_df = NULL
    if (input$covid19CaseMonth == "January") { month_df = covid19CaseSurv01 }
    else if (input$covid19CaseMonth == "February") { month_df = covid19CaseSurv02 }
    else if (input$covid19CaseMonth == "March") { month_df = covid19CaseSurv03 }
    else if (input$covid19CaseMonth == "April") { month_df = covid19CaseSurv04 }
    else if (input$covid19CaseMonth == "May") { month_df = covid19CaseSurv05 }
    else if (input$covid19CaseMonth == "June") { month_df = covid19CaseSurv06 }
    else if (input$covid19CaseMonth == "July") { month_df = covid19CaseSurv07 }
    else if (input$covid19CaseMonth == "August") { month_df = covid19CaseSurv08 }
    else if (input$covid19CaseMonth == "September") { month_df = covid19CaseSurv09 }
    else if (input$covid19CaseMonth == "October") { month_df = covid19CaseSurv10 }
    else if (input$covid19CaseMonth == "November") { month_df = covid19CaseSurv11 }
    else if (input$covid19CaseMonth == "December") { month_df = covid19CaseSurv12 }

    # Select only the variables based on the selected inputs
    # Always select Case.Earliest.Date and n
    month_df %>%
      data.frame()
  })
  
  
  
  # ------------
  # --- Age ----
  # ------------
  
  # Reactive: All cases grouped by Age
  all_cases_data_age <- reactive({
    covid19CaseSurv_month_filtered() %>%
      group_by(Age.Group) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Age.Group)
  })
  
  # Reactive: # All confirmed cases grouped by Age
  confirmed_cases_data_age <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Confirmation.Status == "Laboratory-confirmed case") %>%
      group_by(Age.Group) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Age.Group)
  })
  
  # Reactive: All Hospitalization cases grouped by Age
  hospitalization_cases_data_age <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Hospitalization == "Yes") %>%
      group_by(Age.Group) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Age.Group)
  })
  
  # Reactive: All ICU cases grouped by Age
  icu_cases_data_age <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(ICU == "Yes") %>%
      group_by(Age.Group) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Age.Group)
  })
  
  # Reactive: All Death cases grouped by Age
  death_cases_data_age <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Death == "Yes") %>%
      group_by(Age.Group) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Age.Group)
  })
  
  
  # Generate Covid Plotly Summary Plot by Month
  output$covid19CaseSurv_AgePlotSummary <- renderPlotly({
    
    # First, all cases
    plot <- plot_ly(
        data=all_cases_data_age(),
        x=~Age.Group, 
        y=~Count,
        type="bar",
        orientation="v",
        name='All Cases',
        hoverinfo="text",
        text=~paste0(
          "Age Group: ", Age.Group,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, Confirmed Cases
    plot <- plot %>%
      add_bars(
        data=confirmed_cases_data_age(),
        x=~Age.Group,
        y=~Count,
        name='Confirmed',
        hoverinfo="text",
        text=~paste0(
          "Age Group: ", Age.Group,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )

    # Next, Hospitalizations
    plot <- plot %>%
      add_bars(
        data=hospitalization_cases_data_age(),
        x=~Age.Group,
        y=~Count,
        name='Hospitalized',
        hoverinfo="text",
        text=~paste0(
          "Age Group: ", Age.Group,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )

    # Next, ICU
    plot <- plot %>%
      add_bars(
        data=icu_cases_data_age(),
        x=~Age.Group,
        y=~Count,
        name='ICU',
        hoverinfo="text",
        text=~paste0(
          "Age Group: ", Age.Group,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )

    # Next, Death Cases
    plot <- plot %>%
      add_trace(
        data=death_cases_data_age(),
        x=~Age.Group,
        y=~Count,
        name='Death',
        hoverinfo="text",
        text=~paste0(
          "Age Group: ", Age.Group,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Finally, add the layout of the plot
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
          title="Age Group", 
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
  })
  
  
  # Generate Covid Age Summary Table by Month
  output$covid19CaseSurv_AgeTableSummary <- DT::renderDataTable({
    
    # First, all cases
    all_cases_age <- all_cases_data_age() %>%
      rename(
        `All Cases`=Count,
        `% All Cases`=Percent
      )

    # Next, Confirmed Cases
    confirmed_cases_age <- confirmed_cases_data_age() %>%
      rename(
        `Confirmed Cases`=Count,
        `% Confirmed Cases`=Percent
      )

    # Next, Hospitalizations
    hospitalization_cases_age <- hospitalization_cases_data_age() %>%
      rename(
        `Hospitalized Cases`=Count,
        `% Hospitalized Cases`=Percent
      )

    # Next, ICU Cases
    icu_cases_age <- icu_cases_data_age() %>%
      rename(
        `ICU Cases`=Count,
        `% ICU Cases`=Percent
      )

    # Next, Death Cases
    death_cases_age <- death_cases_data_age() %>%
      rename(
        `Death Cases`=Count,
        `% Death Cases`=Percent
      )

    # Finally, merge them all and add total row
    all_cases_age %>%
      full_join(confirmed_cases_age, by="Age.Group") %>%
      full_join(hospitalization_cases_age, by="Age.Group") %>%
      full_join(icu_cases_age, by='Age.Group') %>%
      full_join(death_cases_age, by='Age.Group') %>%
      adorn_totals("row")
  })
  
  
  
  # --------------
  # --- GENDER ---
  # --------------
  
  # Reactive: All cases grouped by Gender
  all_cases_data_gender <- reactive({
    covid19CaseSurv_month_filtered() %>%
      group_by(Gender) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Gender)
  })
  
  # Reactive: # All confirmed cases grouped by Gender
  confirmed_cases_data_gender <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Confirmation.Status == "Laboratory-confirmed case") %>%
      group_by(Gender) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Gender)
  })
  
  # Reactive: All Hospitalization cases grouped by Gender
  hospitalization_cases_data_gender <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Hospitalization == "Yes") %>%
      group_by(Gender) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Gender)
  })
  
  # Reactive: All ICU cases grouped by Gender
  icu_cases_data_gender <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(ICU == "Yes") %>%
      group_by(Gender) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Gender)
  })
  
  # Reactive: All Death cases grouped by Gender
  death_cases_data_gender <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Death == "Yes") %>%
      group_by(Gender) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Gender)
  })
  
  
  # Generate Covid Plotly Summary Plot by Month
  output$covid19CaseSurv_GenderPlotSummary <- renderPlotly({
    
    # First, all cases
    plot <- plot_ly(
      data=all_cases_data_gender(),
      x=~Gender, 
      y=~Count,
      type="bar",
      orientation="v",
      name='All Cases',
      hoverinfo="text",
      text=~paste0(
        "Gender: ", Gender,
        "<br>Count: ", comma(Count, format="d"),
        "<br>Percent: ", round(Percent, 2), "%"
      )
    )
    
    # Next, Confirmed Cases
    plot <- plot %>%
      add_bars(
        data=confirmed_cases_data_gender(),
        x=~Gender,
        y=~Count,
        name='Confirmed',
        hoverinfo="text",
        text=~paste0(
          "Gender: ", Gender,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, Hospitalizations
    plot <- plot %>%
      add_bars(
        data=hospitalization_cases_data_gender(),
        x=~Gender,
        y=~Count,
        name='Hospitalized',
        hoverinfo="text",
        text=~paste0(
          "Gender: ", Gender,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, ICU
    plot <- plot %>%
      add_bars(
        data=icu_cases_data_gender(),
        x=~Gender,
        y=~Count,
        name='ICU',
        hoverinfo="text",
        text=~paste0(
          "Gender: ", Gender,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, Death Cases
    plot <- plot %>%
      add_trace(
        data=death_cases_data_gender(),
        x=~Gender,
        y=~Count,
        name='Death',
        hoverinfo="text",
        text=~paste0(
          "Gender: ", Gender,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Finally, add the layout of the plot
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
          title="Gender", 
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
  })
  
  
  # Generate Covid Gender Summary Table by Month
  output$covid19CaseSurv_GenderTableSummary <- DT::renderDataTable({
    
    # First, all cases
    all_cases_gender <- all_cases_data_gender() %>%
      rename(
        `All Cases`=Count,
        `% All Cases`=Percent
      )
    
    # Next, Confirmed Cases
    confirmed_cases_gender <- confirmed_cases_data_gender() %>%
      rename(
        `Confirmed Cases`=Count,
        `% Confirmed Cases`=Percent
      )
    
    # Next, Hospitalizations
    hospitalization_cases_gender <- hospitalization_cases_data_gender() %>%
      rename(
        `Hospitalized Cases`=Count,
        `% Hospitalized Cases`=Percent
      )
    
    # Next, ICU Cases
    icu_cases_gender <- icu_cases_data_gender() %>%
      rename(
        `ICU Cases`=Count,
        `% ICU Cases`=Percent
      )
    
    # Next, Death Cases
    death_cases_gender <- death_cases_data_gender() %>%
      rename(
        `Death Cases`=Count,
        `% Death Cases`=Percent
      )
    
    # Finally, merge them all and add total row
    all_cases_gender %>%
      full_join(confirmed_cases_gender, by="Gender") %>%
      full_join(hospitalization_cases_gender, by="Gender") %>%
      full_join(icu_cases_gender, by='Gender') %>%
      full_join(death_cases_gender, by='Gender') %>%
      adorn_totals("row")
  })
  
  
  
  # --- Race ---
  # ------------
  
  # Reactive: All cases grouped by Race
  all_cases_data_race <- reactive({
    covid19CaseSurv_month_filtered() %>%
      group_by(Race) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Race)
  })
  
  # Reactive: # All confirmed cases grouped by Race
  confirmed_cases_data_race <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Confirmation.Status == "Laboratory-confirmed case") %>%
      group_by(Race) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Race)
  })
  
  # Reactive: All Hospitalization cases grouped by Gender
  hospitalization_cases_data_race <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Hospitalization == "Yes") %>%
      group_by(Race) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Race)
  })
  
  # Reactive: All ICU cases grouped by Race
  icu_cases_data_race <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(ICU == "Yes") %>%
      group_by(Race) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Race)
  })
  
  # Reactive: All Death cases grouped by Race
  death_cases_data_race <- reactive({
    covid19CaseSurv_month_filtered() %>%
      filter(Death == "Yes") %>%
      group_by(Race) %>%
      summarise(
        Count=sum(Count)
      ) %>%
      ungroup() %>%
      mutate(
        Percent=round(Count / sum(Count) * 100, 2)
      ) %>%
      arrange(Race)
  })
  
  
  # Generate Covid Plotly Summary Plot by Month
  output$covid19CaseSurv_RacePlotSummary <- renderPlotly({
    
    # First, all cases
    plot <- plot_ly(
      data=all_cases_data_race(),
      x=~Race, 
      y=~Count,
      type="bar",
      orientation="v",
      name='All Cases',
      hoverinfo="text",
      text=~paste0(
        "Race: ", Race,
        "<br>Count: ", comma(Count, format="d"),
        "<br>Percent: ", round(Percent, 2), "%"
      )
    )
    
    # Next, Confirmed Cases
    plot <- plot %>%
      add_bars(
        data=confirmed_cases_data_race(),
        x=~Race,
        y=~Count,
        name='Confirmed',
        hoverinfo="text",
        text=~paste0(
          "Race: ", Race,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, Hospitalizations
    plot <- plot %>%
      add_bars(
        data=hospitalization_cases_data_race(),
        x=~Race,
        y=~Count,
        name='Hospitalized',
        hoverinfo="text",
        text=~paste0(
          "Race: ", Race,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, ICU
    plot <- plot %>%
      add_bars(
        data=icu_cases_data_race(),
        x=~Race,
        y=~Count,
        name='ICU',
        hoverinfo="text",
        text=~paste0(
          "Race: ", Race,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Next, Death Cases
    plot <- plot %>%
      add_trace(
        data=death_cases_data_race(),
        x=~Race,
        y=~Count,
        name='Death',
        hoverinfo="text",
        text=~paste0(
          "Race: ", Race,
          "<br>Count: ", comma(Count, format="d"),
          "<br>Percent: ", round(Percent, 2), "%"
        )
      )
    
    # Finally, add the layout of the plot
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
          title="Race", 
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
  })
  
  
  # Generate Covid Race Summary Table by Month
  output$covid19CaseSurv_RaceTableSummary <- DT::renderDataTable({
    
    # First, all cases
    all_cases_race <- all_cases_data_race() %>%
      rename(
        `All Cases`=Count,
        `% All Cases`=Percent
      )
    
    # Next, Confirmed Cases
    confirmed_cases_race <- confirmed_cases_data_race() %>%
      rename(
        `Confirmed Cases`=Count,
        `% Confirmed Cases`=Percent
      )
    
    # Next, Hospitalizations
    hospitalization_cases_race <- hospitalization_cases_data_race() %>%
      rename(
        `Hospitalized Cases`=Count,
        `% Hospitalized Cases`=Percent
      )
    
    # Next, ICU Cases
    icu_cases_race <- icu_cases_data_race() %>%
      rename(
        `ICU Cases`=Count,
        `% ICU Cases`=Percent
      )
    
    # Next, Death Cases
    death_cases_race <- death_cases_data_race() %>%
      rename(
        `Death Cases`=Count,
        `% Death Cases`=Percent
      )
    
    # Finally, merge them all and add total row
    all_cases_race %>%
      full_join(confirmed_cases_race, by="Race") %>%
      full_join(hospitalization_cases_race, by="Race") %>%
      full_join(icu_cases_race, by='Race') %>%
      full_join(death_cases_race, by='Race') %>%
      adorn_totals("row")
  })
  
  
  
  
  
  
  
  
  
  
  # # Generate Covid Plotly Summary Plot by Month
  # output$covid19CaseSurv_RacePlotSummary <- renderPlotly({
  #   
  #   data <- covid19CaseSurv_month_filtered() %>%
  #     group_by(Race) %>%
  #     summarise(
  #       Count=sum(Count)
  #     ) %>%
  #     ungroup() %>%
  #     mutate(
  #       Percent=Count / sum(Count) * 100
  #     ) %>%
  #     arrange(Race)
  #   
  #   data %>%
  #     plot_ly(
  #       x=~Race, 
  #       y=~Count,
  #       name='Race',
  #       hoverinfo="text",
  #       text=~paste0(
  #         "Race: ", Race,
  #         "<br>Count: ", comma(Count, format="d"),
  #         "<br>Percent: ", round(Percent, 2), "%"
  #       )
  #     ) %>%
  #     add_bars() %>%
  #     layout(
  #       yaxis=list(
  #         title="Count",
  #         zerolinecolor = toRGB("#cdcdcd"),
  #         zerolinewidth = 1,
  #         linecolor = toRGB("#cdcdcd"),
  #         linewidth = 1,
  #         tickfont=list(color=c("#cdcdcd")),
  #         titlefont = list(color=c("#cdcdcd")),
  #         gridcolor = toRGB("gray50"),
  #         gridwidth = 1
  #       ),
  #       xaxis=list(
  #         title="Race", 
  #         tickangle=-45,
  #         zerolinecolor = toRGB("#cdcdcd"),
  #         zerolinewidth = 1,
  #         linecolor = toRGB("#cdcdcd"),
  #         linewidth = 1,
  #         tickfont=list(color=c("#cdcdcd")),
  #         titlefont = list(color=c("#cdcdcd"))
  #         # tickvals = c(
  #         #   "American Indian/Alaska Native",
  #         #   "Asian",
  #         #   "Black",
  #         #   "Hispanic/Latino",
  #         #   "Missing",
  #         #   "Multiple/Other",
  #         #   "Native Hawaiian/Other Pacific Islander",
  #         #   "Unknown",
  #         #   "White"
  #         # ), 
  #         # ticktext = c(
  #         #   "AIAN", 
  #         #   "Asian",
  #         #   "African American",
  #         #   "Latino",
  #         #   "Missing",
  #         #   "Multiracial/Other",
  #         #   "NHPI",
  #         #   "Unknown",
  #         #   "Caucasian"
  #         # )
  #       ),
  #       showlegend=FALSE,
  #       plot_bgcolor=toRGB("#2d3741"), # Customize the background color of the plot
  #       paper_bgcolor=toRGB("#2d3741") # Customize the background color of the margin
  #     )
  # })
  # 
  # # Generate Covid Gender Summary Table by Month
  # output$covid19CaseSurv_RaceTableSummary <- DT::renderDataTable({
  #   
  #   covid19CaseSurv_month_filtered() %>%
  #     group_by(Race) %>%
  #     summarise(
  #       Count=sum(Count)
  #     ) %>%
  #     ungroup() %>%
  #     mutate(
  #       Percent=round(Count / sum(Count) * 100, 2)
  #     ) %>%
  #     arrange(Race) %>%
  #     adorn_totals("row")
  # },
  #   # Make Horizontal scrollable
  #   options = list(scrollX = TRUE)
  # )
  # 
  
  
  
  
  
  
  # Get the month from the user selection
  # Because of Single ID Requirement, this has to be individualize
  # TODO: Re-write this code better
  output$selectedCovidMonth1 <- renderText({
    input$covid19CaseMonth
  })
  output$selectedCovidMonth2 <- renderText({
    input$covid19CaseMonth
  })
  output$selectedCovidMonth3 <- renderText({
    input$covid19CaseMonth
  })
  output$selectedCovidMonth4 <- renderText({
    input$covid19CaseMonth
  })
  output$selectedCovidMonth5 <- renderText({
    input$covid19CaseMonth
  })
  output$selectedCovidMonth6 <- renderText({
    input$covid19CaseMonth
  })
  
  # Output: Covid-19 Surveillance Scatterplot
  # output$covid19CaseSurveillance_scatterplot <- renderPlotly({
  #   covid19CaseSurveillance_filtered %>%
  #   plot_ly(
  #     x=~covid19CaseSurveillance_filtered[1],
  #     y=~covid19CaseSurveillance_filtered[2],
  #     type='bar',
  #     name='Female',
  #     color = I('#9C877B')
  #   )
  # })
  
  # plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
  
})