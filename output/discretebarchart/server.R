shinyServer(function(input, output, session) {
  
  ############################################
  # DiscreteBarChart
  
  colors = reactive({
    choice = as.integer(input$colors)
    switch(choice,
           c("","","","",""),
           c("#00303E","#7096AD","#C1D1DE","#FFF9EF","#EC4911"),
           c("#0D0C0D","#123E59","#20788C","#F2EAE4","#BFB7B0"),
           c("#39BF73","#F2A007","#F27507","#F22816","#BF190A"),
           c("#071B26","#498C85","#F1A949","#D38345","#A84B39"))
  })
  
  
  
  # Render line chart
  output$myDiscreteBarChart <- renderDiscreteBarChart({
    # Return a data frame. Each column will be a series in the line chart.
    df = data.frame(
      label = c(LETTERS[1:5]),
      value = c(
                input$a,
                input$b,
                input$c,
                input$d,
                input$e
                )
    )

    return(list( data=df, 
                 xlab=input$xlabel, 
                 ylab=input$ylabel,
                 cols=colors()
                 ))
  })
  
  # End DiscreteBarChart
  ############################################
  
  
  
})
