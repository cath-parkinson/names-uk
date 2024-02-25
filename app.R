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
                 widgets_ui("widgets")
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
  
  widget_inputs <- reactiveValues()
  
  # Modules
  
  widgets_server("widgets",
                 name_data = name_data,
                 widget_inputs = widget_inputs)
  
  chart_freq_server("chart_freq",
                    name_data = name_data,
                    names_to_plot = widget_inputs$select_names,
                    gender = widget_inputs$radio_select_gender)
  
}


shinyApp(ui,
         server)
