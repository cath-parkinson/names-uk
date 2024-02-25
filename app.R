library(dplyr)
library(ggplot2)
library(shiny)
library(shinyWidgets)


ui <- fluidPage(
  
  titlePanel("UK Baby Names")
  
)


server <- function(input,
                    output,
                    session) {
  
  
  
  
}


shinyApp(ui,
         server)
