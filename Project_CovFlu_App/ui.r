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
        ),
        
        # Dropdown menu for messages
        # --------------------------
        
        dropdownMenu(
            type = "messages", 
            badgeStatus = "success",
            
            messageItem(
                "Support Team",
                "This is the content of a message.",
                time = "5 mins"
            ),
            
            messageItem(
                "Support Team",
                "This is the content of another message.",
                time = "2 hours"
            ),
            
            messageItem(
                "New User",
                "Can I get some help?",
                time = "Today"
            )
        ),
        
        # Dropdown menu for notifications
        # -------------------------------
        
        dropdownMenu(
            
            type = "notifications", 
            badgeStatus = "warning",
            notificationItem(
                icon = icon("users"),
                status = "info",
                "5 new members joined today"
            ),
            
            notificationItem(
                icon = icon("warning"),
                status = "danger",
                "Resource usage near limit."
            ),
            
            notificationItem(
                icon = icon("shopping-cart", lib = "glyphicon"),
                status = "success", 
                "25 sales made"
            ),
            
            notificationItem(
                icon = icon("user", lib = "glyphicon"),
                status = "danger", 
                "You changed your username"
            )
        ),
        
        # Dropdown menu for tasks, with progress bar
        # ------------------------------------------
        
        dropdownMenu(
            type = "tasks",
            badgeStatus = "danger",
            
            taskItem(
                value = 20, 
                color = "aqua",
                "Refactor code"
            ),
            
            taskItem(
                value = 40,
                color = "green",
                "Design new layout"
            ),
            
            taskItem(
                value = 60, 
                color = "yellow",
                "Another task"
            ),
            
            taskItem(
                value = 80, 
                color = "red",
                "Write documentation"
            )
        )
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
            
            # Link to the Geographical Dashboard
            menuItem(
                "Geographical",
                tabName = "geographicalDashboard",
                icon = icon("dashboard")
            ),

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
        
        # Dropdown Select for Covid-19 Correlation Variables
        selectizeInput(
            "covid19Dimensions",
            "Covid-19 Dimensions",
            Covid19Dimensions,
            selected=c(),
            multiple=TRUE,
            options=list(maxItems=4)
        )
        
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
                        h2("About this Shiny App")
                    ),
                    
                    # Page Contents
                    box(
                        status = "info",
                        width=12,
                        tags$p(HTML("This is a <strong>simple text example
                                    </strong> to use as a simple placeholder.
                                    Further contents will go here in the near
                                    future."))
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
                    
                    # # Covid Value box 1
                    # # Static Value box
                    # infoBox(10 * 2, "Covid Box"),
                    # 
                    # # Covid Value box 2
                    # # Dynamic valueBoxes
                    # # valueBoxOutput("age_covidbox2"),
                    # infoBox(10 * 2, "Flu Box", icon = icon("credit-card")),
                    # 
                    # 
                    # # Flu Value box 1
                    # # Static Value box
                    # infoBox(10 * 2, "Flu Box", icon = icon("credit-card")),
                    # 
                    # # Flu Value box 2
                    # # Dynamic value Box
                    # valueBoxOutput("age_flubox2"),
                    # # infoBox(10 * 2, "Flu Box", icon = icon("credit-card")),
                    

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
                            HTML('<h4 class="plotTitle">This Is A Plot Title</h4>'),
                            plotlyOutput('fluCasesAge')
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
                            HTML('<h4 class="plotTitle">This Is A Plot Title</h4>'),
                            plotlyOutput('fluCasesGender')
                        )
                    ),
                    
                    # Dashboard Visuals: Full-Width - Covid
                    column(
                        status = "danger",
                        collapsible = TRUE,
                        width = 12,
                        tags$div(
                            HTML(paste('<h4 class="plotTitle">Covid-19 Cases by Gender in', textOutput("selectedCovidMonth4", inline=TRUE), '2020<br><small>(Data Source: <a href="https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf" target="_blank">cdc.gov</a>)</small></h4>')),
                            DT::dataTableOutput("covid19CaseSurv_GenderTableSummary")
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
                            HTML('<h4 class="plotTitle">This Is A Plot Title</h4>'),
                            plotlyOutput('fluCasesRace')
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
                    )
                )
            ),
            # --- End of Race Dashboard
            
            
            
            # Page 5 - Geographical Dashboard
            # -------------------------------
            
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
                        tags$p(HTML("This is a <strong>simple text example</strong>
                                    to use as a simple placeholder."))
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
                        tags$p(HTML("List of data sources will go here."))
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
                        tags$p(HTML("Contact information will go here."))
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
