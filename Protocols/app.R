library(shiny)
library(tidyverse)
library(data.table)

##### The code block can be styled with ShinyAce: https://github.com/trestletech/shinyAce


df_test <- mtcars
r_code <- "ggplot(data=mtcars, aes(x=disp, y=wt)) + 
 geom_point() +
 geom_smooth() +
NULL"

######## Reading all relevant, tidy CSV files
data_files <- list.files(pattern = glob2rx("protocol*csv"))
dat <- lapply(data_files, data.table::fread)
names(dat) <- paste0('df_', 1:5)

######## Reading all relevant R scripts with ggplot code
code_files <- list.files(pattern = glob2rx("protocol*R"))
cod <- lapply(code_files, readr::read_file)


protocol_list <- c(1:length(code_files))
names(protocol_list) <- paste("Protocol",c(1:length(code_files)))


ui <- fluidPage(
  #Styling to use a monospaced font for the ggplot code
  tags$head(
    tags$style("#ggplotCode {font-family: monospace; font-size:12px;}")
  ),
  titlePanel("DataViz Protocols: from code to plot"),
  
  sidebarLayout(
    sidebarPanel(width=6,
                 
                 h3("Code:"),
                 div(
                   style = "display: grid; 
                            grid-template-columns: 30% 20% 30% 10%;
                            grid-gap: 10px; height:40px;
                   # border: 1px solid blue;
                   ",

                   selectInput("number", NULL, choices = protocol_list, selected = "1"),
                   actionButton("reset", "Reset code", style='height:34px;'),

                   NULL
                 ),
                 (textAreaInput("ggplotCode", NULL, cod[[1]], width = "100%", height="800px")),
                 # div(
                 #   style = "display: flex; flex-wrap: wrap;",
                 #   div(
                 #     style = "flex: 1;",
                 #     textInput("inputA", "X")
                 #   ),
                 #   div(
                 #     style = "flex: 1;",
                 #     textInput("inputB", "Y")
                 #   ),
                 #   div(
                 #     style = "flex: 1;",
                 #     textInput("inputC", "Z")
                 #   )
                 # ),
                 # div(
                 #   style = "display: grid; 
                 #            grid-template-columns: 20% 40% 20%;
                 #            grid-gap: 10px;",
                 #   
                 #   textInput("inputA", "X"),
                 #   textInput("inputA", "X2"),
                 #   
                 #   textInput("inputB", "Y")
                 # ),
                 # NULL
    ),
  
  mainPanel(width = 6,
    # actionButton("run", "Run!"),
    h3("Plot:"), 
    div(
      style = "display: grid; 
                            grid-template-columns: 20% 20% 10% 10%;
                            grid-gap: 10px;",
    numericInput("plot_height", "Height: ", value = 400),
    numericInput("plot_width", "Width:", value = 600)
    ),
plotOutput("displayPlot", height="100%", width="80%"),
    

    h3("Data:"), verbatimTextOutput("displayData")
    )
  )
)

server <- function(input, output, session) {

  #Resetting the code to the original value when the 'reset' button is clicked
#  observeEvent(input$reset, {updateTextAreaInput(session, inputId = "ggplotCode", value = paste(cod[[as.numeric(input$number)]], collapse = " "))})
  
  observe({
    input$reset
    updateTextAreaInput(session, inputId = "ggplotCode", value = paste(cod[[as.numeric(input$number)]], collapse = " "))
    })
  
  ##### Set width and height of the plot area
  width <- reactive ({ input$plot_width })
  height <- reactive ({ input$plot_height })
  
  
  output$displayData <- renderPrint({head(dat[[as.numeric(input$number)]])})
  
  codeInput <- reactive({
    
    #Hitting the run button reads and runs the code
    input$run
    isolate(input$ggplotCode)
    })

  output$displayPlot <- renderPlot(width = width, height = height, {
    df <- dat[[as.numeric(input$number)]]
    code <- (input$ggplotCode)
    eval(parse(text=code))
    })
  
}
 
shinyApp(ui, server)
