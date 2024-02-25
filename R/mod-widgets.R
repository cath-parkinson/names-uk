# Module: Widgets allowing the user to update the charts

widgets_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    # Testing
    actionBttn(
      inputId = ns("debug"),
      label = "debug"
    ),
    
    radioGroupButtons(
      inputId = ns("radio_select_gender"),
      label = "Select gender(s):",
      choices = c("Girl", "Boy", "Both")
    ),
    
    pickerInput(
      inputId = ns("select_names"),
      label = "Select name(s):",
      choices = NULL,
      multiple = TRUE,
      options = list(
        `live-search` = TRUE
      )
    )
    
  )
  
}

widgets_server <- function(id,
                           name_data){
  
  moduleServer(id, function(input, output, session){
    
    # Testing
    observeEvent(input$debug, {
      browser()
    })
    
    observe({
      
      updatePickerInput(session,
                        inputId = "select_names",
                        choices = name_data %>% dplyr::pull(name) %>% unique(),
                        selected = (name_data %>% dplyr::pull(name) %>% unique())[1])
      
    })
    
  })
  
}


