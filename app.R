library(dplyr)
library(ggplot2)
library(shiny)
library(shinyWidgets)
library(shinythemes)


ui <- fluidPage(
  
  theme = shinytheme("united"),
  
  navbarPage(
    
    title = "UK Baby Names",
    tabPanel("Explore",
             sidebarLayout(
               sidebarPanel(
                 textInput("text", "Enter text:")
               ),
               mainPanel(
                 textOutput("text_output")
               )
             )
    )
  )
  
)


server <- function(input,
                   output,
                   session) {
  
  output$text_output <- renderText({
    input$text
  })
  
}


shinyApp(ui,
         server)
