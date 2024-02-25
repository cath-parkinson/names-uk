# Module: Name frequency over time chart

chart_freq_ui <- function(id) {
  
  ns <- NS(id)
  
  fluidRow(
    column(11,
           plotOutput(ns("chart_freq"))),
    column(1,
           downloadButton(ns("dnld"),
                          label = ""),
           # Debug button - comment out in production
           # actionBttn(ns("debug_chart_freq"),
           #            "Debug")
           )
  )
  
}

chart_freq_server <- function(id,
                              name_data,
                              names_to_plot,
                              gender) {
  
  moduleServer(id, function(input, output, session) {
    
    observeEvent(input$debug_chart_freq, {
      browser()
    })
    
    chart <- reactive({
      plot_name_freq_over_time(name_data = name_data,
                               names_to_plot = names_to_plot(),
                               gender = gender())
      })
    
    output$chart_freq <- renderPlot({chart()})
    
    output$dnld <- downloadHandler(
      filename = function() {"name_freq_over_time.png"},
      content = function(file) {ggsave(file,
                                       chart())}
    )
    
    
  })
  
}


chart_freq_demo <- function() {
  
  source(file.path("R",
                   "chart-name-freq-time.R"))
  
  ui <- fluidPage(chart_freq_ui("x"))
  
  server <- function(input,
                     output,
                     session) {
    
    name_data <- readRDS(file.path("data",
                                   "sim_data_1.rds"))
    
    names_to_plot <- reactive({
      c("Alysha",
        "Amaan",
        "Brandon")
    })
    
    gender <- reactive({"All"})
    
    chart_freq_server("x",
                     name_data = name_data,
                     names_to_plot = names_to_plot,
                     gender = gender)
    
    
  }
  
  shinyApp(ui,
           server)
  
}
