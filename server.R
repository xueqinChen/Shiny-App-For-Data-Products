library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    
    getExpoMeans <- reactive({
        set.seed(input$seed)
        
        lambda <- input$sliderLambda
        n <- input$sliderNObs ## number of observations for exp
        s <- input$sliderNsim  ## number of simulations
        
        ## s times simulations
        mns <- NULL
        for(i in 1:s){
            mns = c(mns,mean(rexp(n, lambda)))
        }
        mns
    })
    
    sampleMeanCalc <- reactive({
        mns <- getExpoMeans()
        round(mean(mns), 4)
    })
    
    sampleVarCalc <- reactive({
        mns <- getExpoMeans()
        round(var(mns),4)
    })
    
    thoMeanCalc <- reactive({
        round(1/input$sliderLambda, 3)
    })
    
    thoVarCalc <- reactive({
        n <- input$sliderNObs
        sd <- 1/input$sliderLambda
        round((sd^2)/n, 3)
    })
    
    
    output$plot1 <- renderPlot({
        mns <- getExpoMeans()
        ## thoretical mean
        thoreMean <- thoMeanCalc()
        ## sample mean
        sampleMean <- sampleMeanCalc()
        

        par(mfrow = c(1, 2), mar = c(6, 6, 4, 2))
        hist(mns, probability = TRUE, main="Histogram of sample mean", xlab="means of exponentials")
        abline(v=sampleMean, col="red",lwd=2)
        hist(mns, probability = TRUE,main="Histogram of thoretical mean", xlab ="means of exponentials")
        abline(v=thoreMean, col="red",lwd=2)
        })
    output$sampleMean <- renderText({
        sampleMeanCalc()
    })
    output$theoMean <- renderText({
        thoMeanCalc()
    })
    
    output$plot2 <- renderPlot({
        mns <- getExpoMeans()
        
        hist(scale(mns), xlim = c(-3,3), ylim=c(0,0.5), probability = TRUE, col="gray", main="Compare distribution", lwd=2)
        lines(density(scale(mns)))
        curve(dnorm(x), xlim=c(-3, 3), col="red", add=TRUE)
        legend(x="topright", c("Sample data distribution","Normal Distribution"), col = c("gray", "red"), lty = 1, lwd=2)
    })
    
    output$sampleVar <- renderText({
        sampleVarCalc()
    })
    output$theoVar <- renderText({
        thoVarCalc()
    })

})