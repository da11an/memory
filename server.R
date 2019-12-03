#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)
library(sound)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    number_list <- reactiveVal(NULL)
    observeEvent(input$nextQuestion, {
        number_list(round(runif(input$digits, min = 0, max = 9)))
        audio_list <- paste0("www/", number_list(), ".mp3")
        print(audio_list)
        do.call(tuneR::bind,
                lapply(audio_list, 
                       function(i) tuneR::readMP3(filename = i))) %>%
            tuneR::writeWave("www/test_audio2.wav")
        
        output$readNumbers <- renderUI({
            tags$audio(id = "audioNums", src = "test_audio2.wav", type = "audio/wav", autoplay = TRUE, controls = NA)
        })
        
        output$enterAnswer <- renderUI({
            tagList(
                textInput("answer", "What numbers did you hear?")
            )
        })
        
    })
    
    streak <- reactiveVal(0)
    observeEvent(input$checkAnswer, {
        if (input$backwards) {
            key <- paste(rev(number_list()), collapse = "")
        } else {
            key <- paste(number_list(), collapse = "")
        }
        
        if (input$answer == key) {
            streak(streak() + 1)
        } else {
            streak(0)
        }
        output$streak <- renderText({
            streak()
        })
    })
    
})
