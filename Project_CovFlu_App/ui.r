# All libraries are imported in global.R

# Variables
customBadgeColor <- "#d81b60"

# A Custom dashboard header with 3 dropdown menus
customHeader <- dashboardHeader(
    
    # Changing Theme logo
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
)


# Define the Application UI: Using Dashboard Layout
shinyUI(dashboardPage(
    
    # Basic Skin
    # skin="black",
    
    # Application Header and Navigation Bar
    customHeader,
    
    # ----- Sidebar Area -----
    dashboardSidebar(
        
        # Slider input for number of bins
        sliderInput(
            "binscount",
            "Number of bins:",
            min = 1,
            max = 50,
            value = 30
        ),
        
        # Select Input for the user to choose an island
        selectInput(
            "island", 
            "Select an island", 
            c("Tenjiou", "Abnet", "Biscounti")
        ),
        
        # The following are list of tabs / Page
        sidebarMenu(
            menuItem(
                "Dashboard",
                tabName = "dashboard",
                icon = icon("dashboard"),
                #badgeLabel = "<",
                # Valid colors are: red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
                badgeColor = "maroon"
            ),
            
            menuItem(
                "Focus on Covid-19",
                tabName = "covid",
                icon = icon("dashboard"),
                #badgeLabel = "<",
                # Valid colors are: red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
                badgeColor = "maroon"
            ),
            
            menuItem(
                "Focus on Influenza",
                tabName = "influenza",
                icon = icon("dashboard"),
                #badgeLabel = "<",
                # Valid colors are: red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
                badgeColor = "maroon"
            ),

            menuItem(
                "About",
                tabName = "about",
                icon = icon("question-circle")
            ),

            menuItem(
                "Data Source",
                tabName = "datasource",
                icon = icon("info-circle")
            ),

            menuItem(
                "Contact",
                tabName = "contact",
                icon = icon("address-card")
            )
        )
    ),
    
    # ----- Main Area -----
    dashboardBody(
        
        # Changing theme
        shinyDashboardThemes(
            theme = "grey_dark"
        ),
        
        # Shiny will look in the www folder for this css file
        tags$head(
            tags$link(
                rel = "stylesheet", 
                type = "text/css", 
                href = "styles.css")
        ),
        
        # The following are pages controlled from the sidebar
        tabItems(
            
            # Page 1 - Location
            tabItem(
                tabName = "dashboard",
                # Start of the fluid body
                fluidRow(
                    # Total width = 12 Units / 2 columns --> width=6
                    column(
                        width = 6, 
                        tags$div(
                            HTML('<h4 class="plotTitle">This Is A Plot Title</h4>'),
                            plotlyOutput('decadeCensus')
                        )
                    ),
                    column(
                        width = 6, 
                        tags$div(
                            HTML('<h4 class="plotTitle">This Is A Plot Title</h4>'),
                            plotlyOutput('decadeFile')
                        )
                    ),
                    column(
                        width = 12, 
                        tags$div(
                            HTML('<h4 class="plotTitle">This Is A Table Title</h4>'),
                            plotlyOutput('generationCensus')
                        )
                    )
                )
            ),
            
            # Page 2 - Focus on Covid-19 Only
            tabItem(
                tabName = "covid",
                # Start of the fluid body
                fluidRow(
                    column(
                        width=12,
                        h2("Covid-19 Focus"),
                        tags$p(HTML("This is a <strong>simple text example</strong> to use as a simple placeholder."))
                    )
                )
            ),
            
            # Page 3 - Focus on Influenza Only
            tabItem(
                tabName = "influenza",
                # Start of the fluid body
                fluidRow(
                    column(
                        width=12,
                        h2("Influenza Focus"),
                        tags$p(HTML("This is a <strong>simple text example</strong> to use as a simple placeholder."))
                    )
                )
            ),
            
            # Page 4 - About Page
            tabItem(
                tabName = "about",
                # Start of the fluid body
                fluidRow(
                    column(
                        width=12,
                        h2("About this App"),
                        tags$p(HTML("This is a <strong>simple text example</strong> to use as a simple placeholder."))
                    )
                )
            ),
            
            # Page 5 - Data Source Page
            tabItem(
                tabName = "datasource",
                # Start of the fluid body
                fluidRow(
                    column(
                        width=12,
                        h2("Data Source"),
                        tags$p(HTML("List of data sources will go here."))
                    )
                )
            ),

            # Page 6 - Contact Page
            tabItem(
                tabName = "contact",
                # Start of the fluid body
                fluidRow(
                    column(
                        width=12,
                        h2("Contact"),
                        tags$p(HTML("Contact page will go here."))
                    )
                )
            )
        )
    )
))
