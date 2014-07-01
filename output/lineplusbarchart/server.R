shinyServer(function(input, output, session) {
  
  ############################################
  # LineChart
  
  
  # Render line chart
  output$myLinePlusBarChart <- renderLinePlusBarChart({
    # Return a data frame. Each column will be a series in the line chart.
    df = datasets::faithful
    colnames(df) = c("Eruption_Time", "Wait_Time")

    return(list( data=df, 
                 bar=c(FALSE, TRUE),
                 ylabL = "Length of Eruption (Min)",
                 ylabR = "Time Between Eruptions (Min)",
                 xlab = "Eruption Number"
                 ))
  })
  
  # End LineChart
  ############################################
  
  
  
})
