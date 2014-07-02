shinyServer(function(input, output, session) {
  
  ############################################
  # Data
  
  chartData = reactive({
    years = 1860:1959
    number = as.vector(datasets::discoveries)
    
    n = 1
    yrLab = vector()
    numVal = vector()
    while(n<length(number)){
      yrLab = c(yrLab, paste(years[n], "-", years[n+9], sep = ""))
      numVal = c(numVal, sum(number[n:(n+9)]))
      n = n+10
    }
    
    data.frame( label = yrLab, value = numVal )
  })
  
  # End Data
  ############################################
  
  ############################################
  # Pie Chart
  
  # Render pie chart
  output$myPieChart <- renderPieChart({
    # Return a data frame. Each column will be a series in the line chart.
    

    return(list( data=chartData(),
                 labelType='value',
                 showTooltips=input$shwTooltip,
                 labelThreshold=input$threshold
                 ))
  })
  
  # End Pie Chart
  ############################################
  
  
  ############################################
  # Donut Chart
  
  # Render pie chart
  output$myDonutChart <- renderPieChart({
    # Return a data frame. Each column will be a series in the line chart.
    
    
    return(list( data=chartData(),
                 labelType='value',
                 donut=TRUE,
                 donutRatio=input$donutRatio,
                 showTooltips=input$shwTooltip,
                 labelThreshold=input$threshold
    ))
  })
  
  # End Donut Chart
  ############################################
  
  
  
})
