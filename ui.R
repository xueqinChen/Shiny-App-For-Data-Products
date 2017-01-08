library(shiny)
library(markdown)
shinyUI(fluidPage(
    titlePanel("Investigation of Exponential Distribution"),
    sidebarLayout(
        sidebarPanel(
            numericInput("seed", "Input the seed ", 
                         value = 5000, min = 1, max = 9999, step = 1),
            sliderInput("sliderLambda", "What is the lambda",
                        0.1, 2, value = 0.3, step = 0.1),
            sliderInput("sliderNsim", "Number of simulations",
                        100, 2000, value = 1000, step = 100),
            sliderInput("sliderNObs", "Number of observations for exp",
                        5, 100, value = 40, step = 5),

            submitButton("Submit")
        ),
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Distribution",
                                 h3("Sample Mean VS Theoretical Mean"),
                                 plotOutput("plot1"),
                                 h5("Sample Mean:"),textOutput("sampleMean"),
                                 h5("Theoretical Mean:"),textOutput("theoMean"),
                                 h5("Theoretical Variance:"),textOutput("theoVar"),
                                 h5("Sample Variance:"),textOutput("sampleVar"),
                                 
                                 h3("Normal distribution VS Exponentials Curve"),
                                 plotOutput("plot2")),

                        tabPanel("About",
                                 mainPanel(
                                     includeMarkdown("readme.Rmd")
                                 ))
            )
        )
    )
))