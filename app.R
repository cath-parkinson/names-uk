library(dplyr)
library(ggplot2)
library(shiny)
library(shinyWidgets)
library(shinythemes)


ui <- fluidPage(
  
  theme = shinytheme("united"),
  
  titlePanel("UK Baby Names")
  
)


server <- function(input,
                    output,
                    session) {
  
  
  
  
}


shinyApp(ui,
         server)
