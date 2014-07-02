shinyServer(function(input, output, session) {
  
  ############################################
  # multiBarChart
  
  ylim = reactive({
    if(input$autoY){
      NULL
    }else{
      input$ylimits
    }
  })
  
  cols = reactive({
    choice = as.integer(input$colors)
    switch(choice,
           rep("", 12),
           cm.colors(12),
           topo.colors(12),
           terrain.colors(12),
           heat.colors(12),
           rainbow(12, start=0.7, end=0.1))
  })
  
  # Render line chart
  output$myMultiBarChart <- renderMultiBarChart({
    # Return a data frame. Each column will be a series in the line chart.
    df = as.data.frame(matrix(datasets::AirPassengers, ncol=12))
    colnames(df) = strtrim(month.name, 3)
    df = cbind(df, x=as.character(1949:1960))

    return(list( data=df, 
                 ylab=input$ylabel,
                 ylim=ylim(),
                 xlab=input$xlabel,
                 xlim=input$xlimits,
                 yTickFormat = ".0f",
                 cols=cols(),
                 showControls = TRUE
                 ))
  })
  
  # See https://github.com/mbostock/d3/wiki/Formatting for formatting codes
  
  # End multiBarChart
  ############################################
  
  
  
})
