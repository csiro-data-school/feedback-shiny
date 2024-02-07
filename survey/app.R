source("../global.R")
ui <- shiny::fluidPage(
  uiOutput("paceInput"),
  actionButton("submit", "Submit")
  )


server <- function(input, output, session) {
  
  formData <- reactive({
    data <- data.frame(timestamp = Sys.time(),
                       response = input$paceInput)
  })
  
  saveData <- function(data) {
    write.table(formData(), outputPath, row.names = FALSE,
                append = TRUE, sep = ",", col.names = FALSE)
  }
 
  output$paceInput <- renderUI({
    input$submit
    tagList(
      radioButtons("paceInput", 
                   "How is the teaching pace right now?",
                   c("Too slow", "Just right", "Too fast"),
                   selected = character(0))
    )
  })
  
  observeEvent(input$submit, {
    saveData()
  })
}

shiny::shinyApp(ui = ui, server = server)
