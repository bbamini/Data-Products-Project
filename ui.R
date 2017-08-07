library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploring Global Socioeconomic Factors"),
  
  # Sidebar with a slider input and select input 
  sidebarLayout(
    sidebarPanel(
      h5('This app explores three global socioeconomic status indicators.'),
      h5('Source of Data:',style="display:inline"), a(href='https://www.kaggle.com/sdorius/countryses', "Kaggle",style="display:inline"),
      h5("The Map tab shows the changes in the economic indicators for different countries."),
      h5("The Best and Worst tab shows the 10 countries with highest values of the indicator and the 10 countries 
         with the lowest values of the indicator"),
      
      h3("Select the Year of Interest"),
      sliderInput("year", "Year",
                  min = 1880, max = 2010, step = 10,
                  value = 1880, animate = TRUE),
      h3("Select the Economic Indicator"),
      selectInput("variable", "Economic Indicators:",
                  c("GDP Per Capita" = "gdppc",
                    "Average Adult Years of Education" = "yrseduc", 
                    "Socioeconomic Status Score" = "ses"))
    ),
    
    # Show a plot of the generated
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Map", br(), 
                           h2("Global Socioeconomic Status"),
                           plotlyOutput("worldmap")                     
                           ),
                  tabPanel("Best and Worst", br(),
                           h4("10 Countries with Highest Indicator values"),
                           tableOutput('best'),
                           h4("10 Countries with Lowest Indicator values"),
                           tableOutput('worst')))
      
    )
  )
))
