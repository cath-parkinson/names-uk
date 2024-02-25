library(dplyr)
library(ggplot2)
library(shiny)
library(shinyWidgets)
library(shinythemes)

name_data <- readRDS(file.path("data",
                               "data.RDS"))

ui <- fluidPage(
  
  theme = shinytheme("united"),
  
  navbarPage(
    
    title = "UK Baby Names",
    tabPanel("Explore",
             sidebarLayout(
               sidebarPanel(
                 # Debug button - comment out in production
                 # actionBttn("debug_main",
                 #            "Debug"),
                 textInput("text", "Enter text:")
               ),
               mainPanel(
                 h3("Name frequency over time"),
                 chart_freq_ui("chart_freq")
               )
             )
    )
  )
  
)


server <- function(input,
                   output,
                   session) {
  
  observeEvent(input$debug_main, {
    browser()
  })
  
  names_to_plot <- reactive({
    c("Alysha",
      "Amaan",
      "Brandon")
  })
  
  gender <- reactive({"All"})
  
  chart_freq_server("chart_freq",
                    name_data = name_data,
                    names_to_plot = names_to_plot,
                    gender = gender)
  
}


shinyApp(ui,
         server)
