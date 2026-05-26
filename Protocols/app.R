library(shiny)
library(tidyverse)
library(data.table)
library(broom)
library(ggrepel)
library(scales)
library(ggbeeswarm)
library(patchwork)

source("geom_flat_violin.R")

r_files <- list.files(pattern = glob2rx("protocol_*.R"))
csv_files <- list.files(pattern = glob2rx("protocol_*.csv"))

get_number <- function(f) {
  as.numeric(gsub(".*?(\\d+).*", "\\1", f))
}

r_numbers <- setNames(sapply(r_files, get_number, USE.NAMES = FALSE), NULL)
csv_numbers <- setNames(sapply(csv_files, get_number, USE.NAMES = FALSE), NULL)

available <- sort(intersect(r_numbers, csv_numbers))

code_list <- setNames(
  lapply(available, function(n) {
    readr::read_file(r_files[which(r_numbers == n)])
  }),
  available
)

data_list <- setNames(
  lapply(available, function(n) {
    data.table::fread(csv_files[which(csv_numbers == n)])
  }),
  available
)

protocol_choices <- setNames(available, paste("Protocol", available))

ui <- fluidPage(
  tags$head(
    tags$style("#ggplotCode {font-family: monospace; font-size:12px;}")
  ),
  titlePanel("DataViz Protocols: from code to plot"),
  sidebarLayout(
    sidebarPanel(width = 6,
      h3("Code:"),
      div(
        style = "display: grid;
                 grid-template-columns: 80px 1fr 80px 80px;
                 grid-gap: 10px; height:40px;",
        actionButton("prev", "◀ Prev", style = "height:34px;"),
        selectInput("number", NULL, choices = protocol_choices, selected = 1),
        actionButton("nextBtn", "Next ▶", style = "height:34px;"),
        actionButton("reset", "Reset", style = "height:34px;")
      ),
      textAreaInput("ggplotCode", NULL, value = "", width = "100%", height = "800px")
    ),
    mainPanel(width = 6,
      h3("Plot:"),
      div(
        style = "display: grid;
                 grid-template-columns: 20% 20% 10% 10%;
                 grid-gap: 10px;",
        numericInput("plot_height", "Height: ", value = 400),
        numericInput("plot_width", "Width:", value = 600)
      ),
      plotOutput("displayPlot", height = "100%", width = "80%"),
      h3("Data:"),
      verbatimTextOutput("displayData")
    )
  )
)

server <- function(input, output, session) {

  observeEvent(input$number, {
    req(input$number)
    idx <- as.character(input$number)
    if (idx %in% names(code_list)) {
      updateTextAreaInput(session, "ggplotCode", value = code_list[[idx]])
    }
  })

  observeEvent(input$reset, {
    req(input$number)
    idx <- as.character(input$number)
    if (idx %in% names(code_list)) {
      updateTextAreaInput(session, "ggplotCode", value = code_list[[idx]])
    }
  })

  observeEvent(input$prev, {
    cur <- as.numeric(input$number)
    pos <- match(cur, available)
    if (pos > 1) {
      updateSelectInput(session, "number", selected = available[pos - 1])
    }
  })

  observeEvent(input$nextBtn, {
    cur <- as.numeric(input$number)
    pos <- match(cur, available)
    if (pos < length(available)) {
      updateSelectInput(session, "number", selected = available[pos + 1])
    }
  })

  width <- reactive({ input$plot_width })
  height <- reactive({ input$plot_height })

  output$displayData <- renderPrint({
    req(input$number)
    idx <- as.character(input$number)
    if (idx %in% names(data_list)) {
      head(data_list[[idx]])
    }
  })

  output$displayPlot <- renderPlot(width = width, height = height, {
    req(input$number, input$ggplotCode)
    idx <- as.character(input$number)
    if (idx %in% names(data_list) && idx %in% names(code_list)) {
      df <- data_list[[idx]]
      code <- input$ggplotCode
      tryCatch(
        eval(parse(text = code)),
        error = function(e) NULL
      )
    }
  })
}

shinyApp(ui, server)
