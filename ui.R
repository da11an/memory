#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Number Readback"),

    # Sidebar with a slider input for number of bins
    shiny::column(
      width = 12,
      uiOutput("readNumbers"),
      wellPanel(
        shinyWidgets::materialSwitch("backwards", "Backwards"),
        uiOutput("enterAnswer"),
        actionButton("checkAnswer", "Check Answer"),
        actionButton("nextQuestion", "Next Question")
      ),
      helpText("You've gotten this many right in a row: "),
      textOutput("streak"),
      
      sliderInput("digits", 
                  "Total Digits", 
                  value = 3, 
                  min = 2, 
                  max = 7, 
                  step = 1, 
                  round = TRUE)
    )
))
