# All libraries are imported in global.R



# Variables
# ---------

customBadgeColor <- "#d81b60"


# Settings Accordion
# ------------------

# # These are setting for the Accordions in the sidebar
# settingsAccordionTitles <- c(
#     "Settings"
# )
# 
# # All the widgets for app settings are defined in this Accordion
# settingsAccordionContents <- list(list(
#     
#     # Slider input for number of bins
#     sliderInput(
#         "binscount",
#         "Number of bins:",
#         min = 1,
#         max = 50,
#         value = 30
#     ),
#     
#     # Select Input for the user to choose an island
#     selectInput(
#         "island", 
#         "Select an island", 
#         c("Tenjiou", "Abnet", "Biscounti")
#     )
# ))



# --------------------------
# APPLICATION UI
# Using Dashboard Layout
# -- 1 - DASHBOARD HEADER
# -- 2 - DASHBOARD SIDEBAR
# -- 3 - DASHBOARD MAIN AREA
# --------------------------

shinyUI(dashboardPage(

    # ---------------------
    # 1 - DDASHBOARD HEADER
    # with 3 dropdown menus
    # ---------------------
    
    dashboardHeader(
        
        # Changing Theme logo
        # -------------------
        
        title = shinyDashboardLogoDIY(
            boldText = "CovFlu",
            mainText = "Project",
            textSize = 16,
            badgeText = "1.0",
            badgeTextColor = "white",
            badgeTextSize = 2,
            badgeBackColor = customBadgeColor,
            badgeBorderRadius = 3
        )
        
        # Dropdown menu for messages
        # --------------------------
        
        # dropdownMenu(
        #     type = "messages", 
        #     badgeStatus = "success",
        #     
        #     messageItem(
        #         "Support Team",
        #         "This is the content of a message.",
        #         time = "5 mins"
        #     ),
        #     
        #     messageItem(
        #         "Support Team",
        #         "This is the content of another message.",
        #         time = "2 hours"
        #     ),
        #     
        #     messageItem(
        #         "New User",
        #         "Can I get some help?",
        #         time = "Today"
        #     )
        # ),
        
        # Dropdown menu for notifications
        # -------------------------------
        
        # dropdownMenu(
        #     
        #     type = "notifications", 
        #     badgeStatus = "warning",
        #     notificationItem(
        #         icon = icon("users"),
        #         status = "info",
        #         "5 new members joined today"
        #     ),
        #     
        #     notificationItem(
        #         icon = icon("warning"),
        #         status = "danger",
        #         "Resource usage near limit."
        #     ),
        #     
        #     notificationItem(
        #         icon = icon("shopping-cart", lib = "glyphicon"),
        #         status = "success", 
        #         "25 sales made"
        #     ),
        #     
        #     notificationItem(
        #         icon = icon("user", lib = "glyphicon"),
        #         status = "danger", 
        #         "You changed your username"
        #     )
        # ),
        
        # Dropdown menu for tasks, with progress bar
        # ------------------------------------------
        
        # dropdownMenu(
        #     type = "tasks",
        #     badgeStatus = "danger",
        #     
        #     taskItem(
        #         value = 20, 
        #         color = "aqua",
        #         "Refactor code"
        #     ),
        #     
        #     taskItem(
        #         value = 40,
        #         color = "green",
        #         "Design new layout"
        #     ),
        #     
        #     taskItem(
        #         value = 60, 
        #         color = "yellow",
        #         "Another task"
        #     ),
        #     
        #     taskItem(
        #         value = 80, 
        #         color = "red",
        #         "Write documentation"
        #     )
        # )
    ),
    # --- End of DASHBOARD HEADER ---
    
    
    
    # -------------------------
    # 2 - DASHBOARD SIDEBAR
    # - List of tabs/pages
    # - List of widget controls
    # -------------------------
    
    dashboardSidebar(

        
        
        # Part 1 - Links to Pages and Dashboards
        # --------------------------------------
        
        sidebarMenu(
            
            # Link to the About Page
            menuItem(
                "About",
                tabName = "aboutPage",
                icon = icon("question-circle")
                # badgeLabel = "<",
                # # Valid colors are: red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
                # badgeColor = "maroon"
            ),
            
            # Link to the Age Dashboard
            menuItem(
                "Age",
                tabName = "ageDashboard",
                icon = icon("dashboard")
            ),
            
            # Link to the Sex Dashboard
            menuItem(
                "Gender",
                tabName = "genderDashboard",
                icon = icon("dashboard")
            ),
            
            # Link to the Race Dashboard
            menuItem(
                "Race",
                tabName = "raceDashboard",
                icon = icon("dashboard")
            ),
            
            # # Link to the Geographical Dashboard
            # menuItem(
            #     "Geographical",
            #     tabName = "geographicalDashboard",
            #     icon = icon("dashboard")
            # ),
            # 
            # # Link to the Correlation Dashboard
            # menuItem(
            #     "Correlations",
            #     tabName = "correlationDashboard",
            #     icon = icon("dashboard")
            # ),

            # Link to the Data Source Page
            menuItem(
                "Data Sources",
                tabName = "dataSourcePage",
                icon = icon("info-circle")
            ),

            # Link to the Contact Page
            menuItem(
                "Contact",
                tabName = "contactPage",
                icon = icon("address-card")
            )
        ),
        
        
        
        # Part 2 - Widgets Settings
        # -------------------------

        tags$h4(
            "Widgets Settings",
            class="widget-settings-title"
        ),
        
        # Month Selection for Covid-19 Variables
        selectInput(
            "covid19CaseMonth",
            "2020 Month for Covid-19 Data",
            choices=month_name,
            selected="December"
        ),
        
        # Month Selection for Flu Variables
        selectInput(
            "fluDeaths2019CaseMonth",
            "2019 Month for Influenza Data",
            choices=month_name,
            selected="December"
        )
        
        # Dropdown Select for Covid-19 Correlation Variables
        # selectizeInput(
        #     "covid19Dimensions",
        #     "Covid-19 Dimensions",
        #     Covid19Dimensions,
        #     selected=c(),
        #     multiple=TRUE,
        #     options=list(maxItems=4)
        # )
        
        # # Date range selection for Covid-19 variables
        # dateRangeInput(
        #     "covid19CaseDateRange",
        #     "Date Range for Covid-19 Data",
        #     start = as.Date(covid19CaseSurv_mindate),
        #     end = as.Date(covid19CaseSurv_maxdate),
        #     min = as.Date(covid19CaseSurv_mindate),
        #     max = as.Date(covid19CaseSurv_maxdate),
        #     format = "yyyy-mm-dd",
        #     startview = "month",
        #     weekstart = 0,
        #     language = "en",
        #     separator = " to ",
        #     width = NULL,
        #     autoclose = TRUE
        # )
    ),
    # --- End of DASHBOARD SIDEBAR
    
    
    
    # --------------------------
    # -- 3 - DASHBOARD MAIN AREA
    # --------------------------
    dashboardBody(
        
        # Important: Leave this in here. This fix the issue with the dashboard height
        # https://github.com/rstudio/shinydashboard/issues/283
        tags$head(tags$style(HTML("body { min-height: 0 !important; }"))),
        
        # Set Dashboard theme
        shinyDashboardThemes(
            theme = "grey_dark"
        ),
        
        # Custom Styles: Shiny will look in the www folder for this css file
        tags$head(
            tags$link(
                rel = "stylesheet", 
                type = "text/css", 
                href = "styles.css")
        ),
        
        
        
        # --------------------
        # Dashboards and Pages
        # --------------------
        
        tabItems(
            
            # Page 1 - About Page
            # -------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "aboutPage",
                
                # Start of the fluid body for contents
                fluidRow(
                    
                    # Page Title
                    column(
                        width=12,
                        h2("About This App")
                    ),
                    
                    # Page Contents
                    box(
                        status = "info",
                        width=12,
                        br(),
                        br(),
                        tags$p(HTML("<p>Throughout the year 2020 and beyond, the term <em>Covid-19</em> has certainly become the most familiar term to our ears.
                                    It is astonishing when we think that back in 2019, hardly anyone has ever heard of the term <em>Covid-19</em> or even knew what a Coronavirus is.</p>
                                    <p>Before <em>Covid-19</em> was drastically popularized however, we have been dealing with another deadly virus: The <em>Influenza</em> virus.</p>
                                    <p>As our communities have gotten used to Covid-19 over time, we have started to hear assumptions such as <em>the expansion of Covid-19 should slow down once we get to the Summer season</em>, or <em>Covid-19 is similar to the Flu.</em>
                                    Clearly, there are assumptions that the Influenza virus and Covid-19 virus share some similarities.</p>
                                    <p>We wondered if there are similarities between the groups of population most affected by these two viruses in terms of demographics.</p>
                                    <p>In this dashboard, we analyze the demographics of those two populations in terms of following dimensions:</p>
                                    <ul>
                                      <li>Age Group</li>
                                      <li>Gender</li>
                                      <li>Race</li>
                                      <li>Disease Cases</li>
                                      <li>Disease Hosptalizations</li>
                                      <li>Resulting Deaths</li>
                                    </ul>
                                    <p>Our driving data questions were:</p>
                                    <ul>
                                      <li><em>Which subgroups of the U.S. population are the most impacted by the Covid-19 virus?</em></li>
                                      <li><em>Which subgroups of the U.S. population are the most impacted by the Influenza virus?</em></li>
                                      <li><em>How do those two subgroups compare against each other?</em></li>
                                    </ul>")
                        ),
                        br(),
                        br()
                    )
                )
            ),
            # --- End of About Page
            
            
            
            # Page 2 - Age Dashboard
            # ----------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "ageDashboard",
                
                # Start of the fluid body for contents
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Age Views")
                    ),
                    
                    # Value Boxes
                    box(
                        status="info",
                        width=12,
                        collapsible = TRUE,
                        
                        # # Static Value box: Covid Value box 1
                        # infoBox(10 * 2, "Flu Box", icon = icon("credit-card"), width=6),
                        
                        # Dynamic valueBox: Covid Total Cases
                        valueBoxOutput("age_covid19TotalCasesCountIn2020", width=6),
                        
                        # Dynamic valueBox: Flu Total Cases
                        valueBoxOutput("age_fluTotalCasesCountIn2019", width=6),
                        
                        # Dynamic valueBox: Covid Cases in selected Month
                        valueBoxOutput("age_covid19CasesCountInMonth", width=3),
                        
                        # Dynamic valueBox: Covid Percent Cases in selected Month vs Total Cases
                        valueBoxOutput("age_covid19CasesPercentInMonth", width=3),
                        
                        # Dynamic valueBox: Flu Cases in selected Month
                        valueBoxOutput("age_fluCasesCountInMonth", width=3),
                        
                        # Dynamic valueBox: Flu Percent Cases in selected Month vs Total Cases
                        valueBoxOutput("age_fluCasesPercentInMonth", width=3),  
                    ),

                    # Dashboard Visuals: Column 1 - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Age in', textOutput("selectedCovidMonth1", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            # tableOutput('covid19CaseSurv_AgeTableSummary')
                            plotlyOutput('covid19CaseSurv_AgePlotSummary')
                        )
                    ),

                    # Dashboard Visuals: Column 2 - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia Deaths by Age in', textOutput("selectedFluMonth1", inline=TRUE), '2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            plotlyOutput('fluDeathCases_AgePlotSummary')
                        )
                    ),

                    # Dashboard Visuals: Full-Width - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Age in', textOutput("selectedCovidMonth2", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("covid19CaseSurv_AgeTableSummary")
                            # tableOutput('covid19CaseSurv_AgeTableSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia Deaths by Age in', textOutput("selectedFluMonth2", inline=TRUE), '2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("fluDeathCases_AgeTableSummary")
                        )
                    )
                )
            ),
            # --- End of Age Dashboard
            
            
            
            # Page 3 - Gender Dashboard
            # -------------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "genderDashboard",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Gender Views"),
                    ),
                    
                    # Dashboard Visuals: Column 1 - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Gender in', textOutput("selectedCovidMonth3", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            # tableOutput('covid19CaseSurv_AgeTableSummary')
                            plotlyOutput('covid19CaseSurv_GenderPlotSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Column 2 - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia Deaths by Gender in', textOutput("selectedFluMonth3", inline=TRUE), '2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            plotlyOutput('fluDeathCases_GenderPlotSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Gender in', textOutput("selectedCovidMonth4", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("covid19CaseSurv_GenderTableSummary")
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia Deaths by Gender in', textOutput("selectedFluMonth4", inline=TRUE), '2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("fluDeathCases_GenderTableSummary")
                        )
                    )
                )
            ),
            # --- End of Gender Dashboard
            
            
            
            # Page 4 - Race Dashboard
            # -----------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "raceDashboard",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Race Views")
                    ),
                    
                    # Dashboard Visuals: Column 1 - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Race in', textOutput("selectedCovidMonth5", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            # tableOutput('covid19CaseSurv_AgeTableSummary')
                            plotlyOutput('covid19CaseSurv_RacePlotSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Column 2 - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia Deaths by Race in', textOutput("selectedFluMonth5", inline=TRUE), '2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            plotlyOutput('fluDeathCases_RacePlotSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Race in', textOutput("selectedCovidMonth6", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("covid19CaseSurv_RaceTableSummary")
                            # tableOutput('covid19CaseSurv_AgeTableSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia Deaths by Race in', textOutput("selectedFluMonth6", inline=TRUE), '2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("fluDeathCases_RaceTableSummary")
                        )
                    )
                )
            ),
            # --- End of Race Dashboard
            
            
            
            # Page 5a - Geographical Dashboard
            # --------------------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "geographicalDashboard",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Geographical Views")
                    ),
                    
                    # Dashboard Visuals
                    box(
                        status = "info",
                        width=12,
                        tags$p(HTML("In development...<strong>Coming Soon!</strong>"))
                    )
                )
            ),
            # --- End of Geographical Dashboard
            
            
            
            # Page 5b - Correlations Dashboard
            # --------------------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "correlationDashboard",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Correlation Views")
                    ),
                    
                    # Dashboard Visuals
                    box(
                        status = "info",
                        width=12,
                        tags$p(HTML("In development...<strong>Coming Soon!</strong>"))
                    )
                )
            ),
            # --- End of Geographical Dashboard
            
            
            
            # Page 6 - Data Source Page
            # -------------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "dataSourcePage",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Page Title
                    column(
                        width=12,
                        h2("Data Sources")
                    ),
                    
                    # Page Contents
                    box(
                        status = "info",
                        width=12,
                        br(),
                        br(),
                        HTML('
                            <p>Centers for Disease Control and Prevention, COVID-19 Response. <em>COVID-19 Case Surveillance Public Data Access, Summary, and Limitations</em>. (version date: December 31, 2020). Accessed January 18, 2021. <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target=_blank>https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf</a></p><br>
                            <p>Centers for Disease Control and Prevention, National Center for Health Statistics. <em>Monthly provisional counts of deaths by age group, sex, and race/ethnicity for select causes of death</em>. (version date: December 17, 2020). Accessed January 18, 2021. <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target=_blank>https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5</a></p><br>
                        ')
                    )
                )
            ),
            # --- End of Data Source Page
            
            
            
            # Page 7 - Contact Page
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "contactPage",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Page Title
                    column(
                        width=12,
                        h2("Contact Information")
                    ),
                    # Page Contents
                    box(
                        status = "info",
                        width=12,
                        br(),
                        br(),
                        tags$div(class="bodyTextContainer",
                                 tags$h4("Maeva Ralafiarindaza"),
                                 HTML("<p><strong>Data Scientist and Developer</strong></p>"),
                                 HTML('<p><a href="https://www.github.com/maevadevs" target=_blank>GitHub</a> |
                                          <a href="https://www.linkedin.com/in/maevaralafiarindaza/" target=_blank>LinkedIn</a> |
                                          <a href="https://www.kaggle.com/maevaralafi" target=_blank>Kaggle</a> | 
                                          <a href="https://maevadevs.github.io/" target=_blank>Blog</a></p>')
                        ),
                        br(),
                        br()
                    )
                )
            )
            # --- End of Contact Page
        )
        # --- End of Dashboards and Pages
    )
    # --- End of DASHBOARD MAIN AREA
))
# --- End of Dashboard Layout
