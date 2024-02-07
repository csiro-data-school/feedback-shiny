library(shiny)
library(ggplot2)

source("../global.R")

ui <- fluidPage(
  
  # Application title
  titlePanel("DataSchool Pace Responses"),
  
  textInput("timePeriod", "Time period (in hours)", value = 3),
  
  uiOutput("responseUI")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  readData <- reactiveFileReader(1000, 
                       session,
                       outputPath,
                       read.csv, 
                       header = FALSE)
  
  getData <- function() {
    
    dat <- readData()
    
    currentTime <- Sys.time()
    
    timePeriod <- as.numeric(input$timePeriod)
    
    dat <- dat[difftime(currentTime, dat$V1, units = "hours") < timePeriod,]
    
    return(dat)
    
  }
  
  output$responseUI <- renderUI({
    if(file.exists(outputPath)) {
      dat <- getData()
    
    p <- ggplot(dat, aes(V2)) +
      geom_bar() +
      stat_count(aes(y = after_stat(count), label = after_stat(count)),
                 geom = "text", vjust = -1) +
      ylab("Responses") +
      xlab("") +
      labs() +
      theme_minimal()
    
    tagList(
      plotOutput(p)
    )} else {
      tagList(
        renderText("There are no responses yet")
      )
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
