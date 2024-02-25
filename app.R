library(dplyr)
library(ggplot2)
library(shiny)
library(shinyWidgets)
library(shinythemes)

name_data <- readRDS(file.path("data",
                               "data.RDS"))

most_popular_girl <- name_data %>% 
  dplyr::filter(year == max(year)) %>% 
  dplyr::filter(gender == "Girl") %>% 
  dplyr::arrange(-count) %>% 
  dplyr::slice(1) %>% 
  dplyr::pull(name)

most_popular_boy <- name_data %>% 
  dplyr::filter(year == max(year)) %>% 
  dplyr::filter(gender == "Boy") %>% 
  dplyr::arrange(-count) %>% 
  dplyr::slice(1) %>% 
  dplyr::pull(name)

name_data_list <- list(name_data = name_data,
                       most_popular_girl = most_popular_girl,
                       most_popular_boy = most_popular_boy)

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
                 name_data_list = name_data_list,
                 widget_inputs = widget_inputs)
  
  chart_freq_server("chart_freq",
                    name_data_list = name_data_list,
                    names_to_plot = widget_inputs$select_names,
                    gender = widget_inputs$radio_select_gender)
  
}


shinyApp(ui,
         server)
