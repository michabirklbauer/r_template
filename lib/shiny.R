#!/usr/bin/env Rscript

library(tidyverse)
library(shiny)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(bootswatch = "brite"),
  titlePanel("Clustering App"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(
        "top_x",
        "Length or Width",
        choices = c("Length", "Width"),
        selected = "Length"
      ),
      uiOutput("xselect"),
      selectInput(
        "top_y",
        "Length or Width",
        choices = c("Length", "Width"),
        selected = "Width"
      ),
      uiOutput("yselect")
      #selectInput("x", "X-Axis", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
      #selectInput("y", "Y-Axis", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
    ),
    mainPanel = mainPanel(
      plotOutput("plot1")
    )
  )
)

server <- function(input, output, session) {
  output$xselect <- renderUI({
    selection <- colnames(iris)[grepl(
      pattern = paste0(input$top_x, "$"),
      colnames(iris)
    )]

    selectInput("x", "X-Axis", choices = selection, selected = "Sepal.Length")
  })

  output$yselect <- renderUI({
    selection <- colnames(iris)[grepl(
      pattern = paste0(input$top_y, "$"),
      colnames(iris)
    )]

    selectInput("y", "Y-Axis", choices = selection, selected = "Sepal.Width")
  })

  output$plot1 <- renderPlot({
    iris %>%
      ggplot(
        aes(x = !!sym(input$x), y = !!sym(input$y), color = Species)
      ) +
      geom_point()
  })
}

app <- shinyApp(ui, server)
