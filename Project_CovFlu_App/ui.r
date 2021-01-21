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
            
            # Link to the Overview Dashboard
            menuItem(
                "Overview",
                tabName = "overviewDashboard",
                icon = icon("dashboard")
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
        
        # Custom ribbon link for github: run ?ribbon_css for all the options
        ribbon_css(
            "https://github.com/maevadevs/project-covflu", 
            color = "white", 
            font_color = "black", 
            border_color = "black", 
            parent_css = list("z-index"="10000")
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
                        tags$p(HTML("<h3>Background Synopsis</h3>
                                    <p>Throughout the year 2020 and beyond, the term <em>Covid-19</em> has certainly become the most familiar term to our ears.
                                    It is astonishing when we think that back in 2019, hardly anyone has ever heard of the term <em>Covid-19</em> or even knew what a Coronavirus is.</p>
                                    <p>Before <em>Covid-19</em> was drastically popularized however, we have been dealing with another deadly virus: The <em>Influenza</em> virus.</p>
                                    <p>As our communities have gotten used to Covid-19 over time, we have started to hear assumptions such as <em>the expansion of Covid-19 should slow down once we get to the Summer season</em>, or <em>Covid-19 is similar to the Flu.</em>
                                    Clearly, there are assumptions that the Influenza virus and Covid-19 virus share some similarities.</p>
                                    <p>We wondered if there are similarities between the groups of population most affected by these two viruses in terms of demographics.</p>
                                    <br>
                                    <h3>App Goals</h3>
                                    <p>In this Shiny dashboard application, we analyze the demographics of those two populations using Covid-19 cases dataset from 2020 and Influenza mortality dataset from 2019. We compare them in terms of the following dimensions:</p>
                                    <ul>
                                      <li>Age Group</li>
                                      <li>Gender</li>
                                      <li>Race</li>
                                      <li>Disease Cases</li>
                                      <li>Disease Hosptalizations</li>
                                      <li>Resulting Deaths</li>
                                    </ul>
                                    <p><strong>Our main driving data questions that we wanted to answer were:</strong></p>
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
            
            
            
            # Page 2 - Overview Dashboard
            # --------------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "overviewDashboard",
                
                # Start of the fluid body for contents
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Overview")
                    ),
                    
                    # Value Boxes: Covid 19 Cases
                    box(
                        # h2("Covid-19 Cases In 2020"),
                        HTML('<h3>Covid-19 Cases In 2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h3>'),
                        status="danger",
                        width=12,
                        collapsible = TRUE,
                        collapsed = TRUE,
                        
                        # # Static Value box: Covid Value box 1
                        # infoBox(10 * 2, "Flu Box", icon = icon("credit-card"), width=6),
                        
                        # Dynamic valueBox: Covid Total Cases
                        valueBoxOutput("overview_covid19TotalCasesCountIn2020", width=12),
                        
                        # Dynamic valueBox: Covid Total Confirmed Cases
                        valueBoxOutput("overview_covid19TotalConfirmedCasesCountIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Percent Confirmed Cases
                        valueBoxOutput("overview_covid19TotalConfirmedCasesPercentIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Total Hospitalization Cases
                        valueBoxOutput("overview_covid19TotalHospitalizationCountIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Percent Hospitalization Cases
                        valueBoxOutput("overview_covid19TotalHospitalizationPercentIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Total ICU Cases
                        valueBoxOutput("overview_covid19TotalIcuCountIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Percent ICU Cases
                        valueBoxOutput("overview_covid19TotalIcuPercentIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Total Death Cases
                        valueBoxOutput("overview_covid19TotalDeathCountIn2020", width=6),
                        
                        # Dynamic valueBox: Covid Percent Death Cases
                        valueBoxOutput("overview_covid19TotalDeathPercentIn2020", width=6),
                        
                        # # Dynamic valueBox: Covid Total Probable Cases
                        # valueBoxOutput("overview_covid19TotalProbableCasesCountIn2020", width=6),
                        
                        # # Dynamic valueBox: Covid Total Probable Cases
                        # valueBoxOutput("overview_covid19TotalProbableCasesCountIn2020", width=6),
                        
                        # # Dynamic valueBox: Covid Total Probable Cases
                        # valueBoxOutput("overview_covid19TotalProbableCasesCountIn2020", width=6)
                    ),
                    
                    # Value Boxes: Covid-19 Deaths
                    box(
                        HTML('<h3>Covid-19 Deaths in 2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h3>'),
                        status="danger",
                        width=6,
                        collapsible = TRUE,
                        collapsed = FALSE,
                        
                        # Dynamic valueBox: Covid-19 Total Death
                        valueBoxOutput("overview_covid19TotalDeathCountIn2020__sub", width=12),
                        
                        # Dynamic valueBox: Covid-19 Death Count in selected Month
                        valueBoxOutput("overview_Covid19DeathCountInMonth", width=6),
                        
                        # Dynamic valueBox: Covid-19 Percent Death in selected Month vs Total Death
                        valueBoxOutput("overview_Covid19DeathPercentInMonth", width=6)
                    ),
                    
                    # Value Boxes: Influenza Deaths
                    box(
                        HTML(paste('<h3>Influenza Deaths in 2019<br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h3>')),
                        status="success",
                        width=6,
                        collapsible = TRUE,
                        collapsed = FALSE,
                        
                        # Dynamic valueBox: Flu Total Deaths
                        valueBoxOutput("overview_fluTotalDeathCountIn2019", width=12),
                        
                        # Dynamic valueBox: Flu Deaths in selected Month
                        valueBoxOutput("overview_fluDeathCountInMonth", width=6),
                        
                        # Dynamic valueBox: Flu Percent Deaths in selected Month vs Total Deaths
                        valueBoxOutput("overview_fluDeathPercentInMonth", width=6)
                    )
                )
            ),
            # --- End of Overview Dashboard
            
            
            
            # Page 3 - Age Dashboard
            # ----------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "ageDashboard",
                
                # Start of the fluid body for contents
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Age Dashboard")
                    ),
                    
                    # # Value Boxes
                    # box(
                    #     status="info",
                    #     width=12,
                    #     collapsible = TRUE,
                    #     collapsed = TRUE,
                    # 
                    #     # # Static Value box: Covid Value box 1
                    #     # infoBox(10 * 2, "Flu Box", icon = icon("credit-card"), width=6),
                    #     
                    #     # Dynamic valueBox: Covid Total Cases
                    #     valueBoxOutput("age_covid19TotalCasesCountIn2020", width=6),
                    #     
                    #     # Dynamic valueBox: Flu Total Cases
                    #     valueBoxOutput("age_fluTotalCasesCountIn2019", width=6),
                    #     
                    #     # Dynamic valueBox: Covid Cases in selected Month
                    #     valueBoxOutput("age_covid19CasesCountInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Covid Percent Cases in selected Month vs Total Cases
                    #     valueBoxOutput("age_covid19CasesPercentInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Flu Cases in selected Month
                    #     valueBoxOutput("age_fluCasesCountInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Flu Percent Cases in selected Month vs Total Cases
                    #     valueBoxOutput("age_fluCasesPercentInMonth", width=3),  
                    # ),

                    # Dashboard Visuals: Column 1 - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 <strong>Cases by Age</strong> in<strong>', textOutput("selectedCovidMonth1", inline=TRUE), '2020</strong><br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
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
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia <strong>Deaths by Age</strong> in <strong>', textOutput("selectedFluMonth1", inline=TRUE), '2019</strong><br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            plotlyOutput('fluDeathCases_AgePlotSummary')
                        )
                    ),

                    # Dashboard Visuals: Full-Width - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 <strong>Cases by Age</strong> in <strong>', textOutput("selectedCovidMonth2", inline=TRUE), '2020</strong><br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
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
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia <strong>Deaths by Age</strong> in <strong>', textOutput("selectedFluMonth2", inline=TRUE), '2019</strong><br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("fluDeathCases_AgeTableSummary")
                        )
                    )
                )
            ),
            # --- End of Age Dashboard
            
            
            
            # Page 4 - Gender Dashboard
            # -------------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "genderDashboard",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Gender Dashboard")
                    ),
                    
                    # # Value Boxes
                    # box(
                    #     status="info",
                    #     width=12,
                    #     collapsible = TRUE,
                    #     collapsed = TRUE,
                    # 
                    #     # # Static Value box: Covid Value box 1
                    #     # infoBox(10 * 2, "Flu Box", icon = icon("credit-card"), width=6),
                    #     
                    #     # Dynamic valueBox: Covid Total Cases
                    #     valueBoxOutput("gender_covid19TotalCasesCountIn2020", width=6),
                    #     
                    #     # Dynamic valueBox: Flu Total Cases
                    #     valueBoxOutput("gender_fluTotalCasesCountIn2019", width=6),
                    #     
                    #     # Dynamic valueBox: Covid Cases in selected Month
                    #     valueBoxOutput("gender_covid19CasesCountInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Covid Percent Cases in selected Month vs Total Cases
                    #     valueBoxOutput("gender_covid19CasesPercentInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Flu Cases in selected Month
                    #     valueBoxOutput("gender_fluCasesCountInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Flu Percent Cases in selected Month vs Total Cases
                    #     valueBoxOutput("gender_fluCasesPercentInMonth", width=3),  
                    # ),
                    
                    # Dashboard Visuals: Column 1 - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 <strong>Cases by Gender</strong> in <strong>', textOutput("selectedCovidMonth3", inline=TRUE), '2020</strong><br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
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
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia <strong>Deaths by Gender</strong> in <strong>', textOutput("selectedFluMonth3", inline=TRUE), '2019</strong><br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            plotlyOutput('fluDeathCases_GenderPlotSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 <strong>Cases by Gender</strong> in <strong>', textOutput("selectedCovidMonth4", inline=TRUE), '2020</strong><br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("covid19CaseSurv_GenderTableSummary")
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Flu
                    box(
                        status = "success",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia <strong>Deaths by Gender</strong> in <strong>', textOutput("selectedFluMonth4", inline=TRUE), '2019</strong><br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("fluDeathCases_GenderTableSummary")
                        )
                    )
                )
            ),
            # --- End of Gender Dashboard
            
            
            
            # Page 5 - Race Dashboard
            # -----------------------
            
            tabItem(
                
                # Tab ID linking from sidebar
                tabName = "raceDashboard",
                
                # Start of the fluid body
                fluidRow(
                    
                    # Dashboard Title
                    box(
                        width=12,
                        h2("Race Dashboard")
                    ),
                    
                    # # Value Boxes
                    # box(
                    #     status="info",
                    #     width=12,
                    #     collapsible = TRUE,
                    #     collapsed = TRUE,
                    #     
                    #     # # Static Value box: Covid Value box 1
                    #     # infoBox(10 * 2, "Flu Box", icon = icon("credit-card"), width=6),
                    #     
                    #     # Dynamic valueBox: Covid Total Cases
                    #     valueBoxOutput("race_covid19TotalCasesCountIn2020", width=6),
                    #     
                    #     # Dynamic valueBox: Flu Total Cases
                    #     valueBoxOutput("race_fluTotalCasesCountIn2019", width=6),
                    #     
                    #     # Dynamic valueBox: Covid Cases in selected Month
                    #     valueBoxOutput("race_covid19CasesCountInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Covid Percent Cases in selected Month vs Total Cases
                    #     valueBoxOutput("race_covid19CasesPercentInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Flu Cases in selected Month
                    #     valueBoxOutput("race_fluCasesCountInMonth", width=3),
                    #     
                    #     # Dynamic valueBox: Flu Percent Cases in selected Month vs Total Cases
                    #     valueBoxOutput("race_fluCasesPercentInMonth", width=3),  
                    # ),
                    
                    # Dashboard Visuals: Column 1 - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 6, 
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 <strong>Cases by Race</strong> in <strong>', textOutput("selectedCovidMonth5", inline=TRUE), '2020</strong><br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
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
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia <strong>Deaths by Race</strong> in <strong>', textOutput("selectedFluMonth5", inline=TRUE), '2019</strong><br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            plotlyOutput('fluDeathCases_RacePlotSummary')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Covid
                    box(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 <strong>Cases by Race</strong> in <strong>', textOutput("selectedCovidMonth6", inline=TRUE), '2020</strong><br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
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
                            HTML(paste('<h4 class="plotTitle">Influenza/Pneumonia <strong>Deaths by Race</strong> in <strong>', textOutput("selectedFluMonth6", inline=TRUE), '2019</strong><br><small>(Data Source: <a href="https://data.cdc.gov/NCHS/Monthly-provisional-counts-of-deaths-by-age-group-/65mz-jvh5" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("fluDeathCases_RaceTableSummary")
                        )
                    )
                )
            ),
            # --- End of Race Dashboard
            
            
            
            # Page 6 - Geographical Dashboard
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
            
            
            
            # Page 7 - Correlations Dashboard
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
            # --- End of Correlations Dashboard
            
            
            
            # Page 8 - Data Source Page
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
            
            
            
            # Page 9 - Contact Page
            # ---------------------
            
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
                                 HTML('<img src="img/me.jpg" height=100 width=100 style="float: left; margin: 1em 1em 1em 0; border-radius: 100%;">'),
                                 tags$h3("Maeva Ralafiarindaza"),
                                 HTML('<p><strong>Data Scientist</strong></p>'),
                                 HTML('<p><a href="https://www.github.com/maevadevs" target=_blank><i class="fa fa-github" style="font-size:25px;color:#cdcdcd;margin:0 1em 0 0;"></i></a>
                                          <a href="https://www.linkedin.com/in/maevaralafiarindaza/" target=_blank><i class="fa fa-linkedin" style="font-size:25px;color:#cdcdcd;margin:0 1em 0 0;"></i></a>
                                          <a href="https://maevadevs.github.io/" target=_blank><i class="fa fa-blog" style="font-size:25px;color:#cdcdcd;margin:0 1em 0 0;"></i></a>
                                          <a href="https://twitter.com/MaevaRalafi" target=_blank><i class="fa fa-twitter" style="font-size:25px;color:#cdcdcd;margin:0 1em 0 0;"></i></a></p>
                                       <br>
                                       <div style="clear: both;"></div>
                                       <p>My professional motivation is founded on the mindset that Data is the new oil: There is a lot of opportunities that we can extract from data. My passion is working with data technology to seek answers to critical questions, figure out solutions to problems, and empower others in their work. I am fascinated by the applications of data in solving problems and enhancing human life. I am mostly interested in the application of Data Science and Machine Learning in Healthcare and Finance.</p>')
                                 
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
