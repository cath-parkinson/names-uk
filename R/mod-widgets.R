# Module: Widgets allowing the user to update the charts

widgets_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    # Testing
    # actionBttn(
    #   inputId = ns("debug"),
    #   label = "debug"
    # ),
    
    radioGroupButtons(
      inputId = ns("radio_select_gender"),
      label = "Select gender(s):",
      choices = c("Girl", "Boy", "All"),
      selected = "All"
    ),
    
    pickerInput(
      inputId = ns("select_names"),
      label = "Select name(s):",
      choices = NULL,
      multiple = TRUE,
      options = list(
        `live-search` = TRUE,
        `actions-box` = TRUE
      )
    )
    
  )
  
}

widgets_server <- function(id,
                           name_data_list,
                           widget_inputs){
  
  moduleServer(id, function(input, output, session){
    
    # Testing
    observeEvent(input$debug, {
      browser()
    })
    
    observe({
      
      updatePickerInput(session,
                        inputId = "select_names",
                        choices = name_data_list$name_data %>% dplyr::pull(name) %>% unique(),
                        selected = c(name_data_list$most_popular_girl, name_data_list$most_popular_boy)
                        )
      
    })
    
    widget_inputs$select_names <- reactive(input$select_names)
    widget_inputs$radio_select_gender <- reactive(input$radio_select_gender)
    
  })
  
}


