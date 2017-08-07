library(shiny)
library(plotly)
library(dplyr)


# Define server logic required to draw global map
shinyServer(function(input, output) {

  
  socio <- read.csv("GLOBCSES.csv", 
                      header = TRUE, colClasses = c("integer", "factor", "factor", "numeric", "numeric", "factor", "numeric", 
                                                    "numeric", "factor", "factor"))
  interest <- socio[, c(3, 4, 5, 7, 8)]
  yr_interest <- reactive({subset(interest, year == input$year)})
  
  
  output$best <- renderTable({
    yr_interest()[order(yr_interest()[input$variable], decreasing = TRUE),][1:10,c(1,3,4,5)]
  })
  
  output$worst <- renderTable({
    yr_interest()[order(yr_interest()[input$variable]),][1:10,c(1,3,4,5)]
  })
  
  
  output$worldmap <- renderPlotly({
  
    test <- subset(socio, year == input$year)  
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = TRUE,
      projection = list(type = 'Mercator')
    )
    
    if (input$variable == "ses") {
      p <- plot_geo(test) %>%
        add_trace(
          z = ~ses, color = ~ses,
          text = test$country, locations = test$country, locationmode = "country names") %>%
        colorbar(title = "SES", limits = c(0, 100)) %>%
        layout(
          geo = g
        )  
    } else if (input$variable == "gdppc") {
      
      p <- plot_geo(test) %>%
        add_trace(
          z = ~gdppc, color = ~gdppc,
          text = test$country, locations = test$country, locationmode = "country names") %>%
        colorbar(title = "GDP Per Capita", limits = c(500, 50000)) %>%
        layout(
          geo = g
        )  
    } else {
      p <- plot_geo(test) %>%
        add_trace(
          z = ~yrseduc, color = ~yrseduc,
          text = test$country, locations = test$country, locationmode = "country names") %>%
        colorbar(title = "Avg. Adult Years Education", limits = c(0, 15)) %>%
        layout(
          geo = g
        )   
    }
    
  })
  
})
