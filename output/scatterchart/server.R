shinyServer(function(input, output, session) {
  
  
  
  ############################################
  # Scatter Chart
  
  # Return colors from color scheme chosen
  colors = reactive({
    choice = as.integer(input$colors)
    switch(choice,
           c("", "", ""),
           c("#39BF73", "#F27507", "#BF190A"),
           c("#123E59", "#20788C", "#BFB7B0"),
           c("#7DA1BE", "#393E42", "#F08544"))
  })
  
  yDist = reactive({
    as.integer(input$yDist)
  })
  
  xDist = reactive({
    as.integer(input$xDist)
  })
  
  # Render line chart
  output$myScatterChart <- renderScatterChart({
    # Return a data frame. Each column will be a series in the line chart.
    y = list(
      Group1 = runif(input$n, min=input$g1Yr[1], max=input$g1Yr[2]),
      Group2 = runif(input$n, min=input$g2Yr[1], max=input$g2Yr[2]),
      Group3 = runif(input$n, min=input$g3Yr[1], max=input$g3Yr[2])
    )
    
    x = data.frame(
      G1 = runif(input$n, min=input$g1Xr[1], max=input$g1Xr[2]),
      G2 = runif(input$n, min=input$g2Xr[1], max=input$g2Xr[2]),
      G3 = runif(input$n, min=input$g3Xr[1], max=input$g3Xr[2])
    )
    
    
    return(list( y=y, 
                 x=x,
                 yDist=yDist(), # This value does not work as a reactive variable.  The initial value is set correctly, but the plot will not reacti to changes.
                 xDist=xDist(), # This value does not work as a reactive variable.  The initial value is set correctly, but the plot will not reacti to changes.
                 names=c("Alpha", "Beta", "Gamma"), 
                 size=c(input$g1sz, input$g2sz, input$g3sz), 
                 ylim=c(100, 1000),
                 xlim=c(100, 1000),
                 cols=colors(),
                 shape=c(input$g1sh, input$g2sh, input$g3sh) ))
  })
  
  
  
  
  
})
