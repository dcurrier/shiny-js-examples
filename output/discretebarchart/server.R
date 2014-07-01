shinyServer(function(input, output, session) {
  
  ############################################
  # DiscreteBarChart
  
  
  # Render line chart
  output$myDiscreteBarChart <- renderDiscreteBarChart({
    # Return a data frame. Each column will be a series in the line chart.
    df = data.frame(
      label = c(LETTERS[1:7]),
      value = c(
                input$a,
                input$b,
                input$c,
                input$d,
                input$e,
                input$f,
                input$g
                )
    )

    return(list( data=df ))
  })
  
  # End DiscreteBarChart
  ############################################
  
  
  
})
