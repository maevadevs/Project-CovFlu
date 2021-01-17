# All libraries are imported in global.R

# Define the Application server logic
shinyServer(function(input, output) {
  
  # Reactive: Filtering the covid-19 data based on the widget input
  covid19CaseSurveillance_filtered <- reactive({
    month_df = NULL
    if (input$covid19CaseMonth == "January") { month_df = covid19CaseSurveillance01 }
    else if (input$covid19CaseMonth == "February") { month_df = covid19CaseSurveillance02 }
    else if (input$covid19CaseMonth == "March") { month_df = covid19CaseSurveillance03 }
    else if (input$covid19CaseMonth == "April") { month_df = covid19CaseSurveillance04 }
    else if (input$covid19CaseMonth == "May") { month_df = covid19CaseSurveillance05 }
    else if (input$covid19CaseMonth == "June") { month_df = covid19CaseSurveillance06 }
    else if (input$covid19CaseMonth == "July") { month_df = covid19CaseSurveillance07 }
    else if (input$covid19CaseMonth == "August") { month_df = covid19CaseSurveillance08 }
    else if (input$covid19CaseMonth == "September") { month_df = covid19CaseSurveillance09 }
    else if (input$covid19CaseMonth == "October") { month_df = covid19CaseSurveillance10 }
    else if (input$covid19CaseMonth == "November") { month_df = covid19CaseSurveillance11 }
    else if (input$covid19CaseMonth == "December") { month_df = covid19CaseSurveillance12 }
    
    month_df
      # Filter based on the Case Ealiest Date
      # filter(`Case Earliest Date` >= as.Date(format(input$covid19CaseDateRange[1]))) %>%
      # filter(`Case Earliest Date` <= as.Date(format(input$covid19CaseDateRange[2]))) %>%
      # Select only the variables based on the selected inputs
      # extract_columns(input$covid19Dimensions)
  })
  
  output$covid19CaseSurveillance_scatterplot <- renderTable({
    covid19CaseSurveillance_filtered()
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