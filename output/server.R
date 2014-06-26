shinyServer(function(input, output, session) {
  
  # Return colors from color scheme chosen
  colors = reactive({
    choice = as.integer(input$colors)
    switch(choice,
           c("", "", ""),
           c("#39BF73", "#F27507", "#BF190A"),
           c("#123E59", "#20788C", "#BFB7B0"),
           c("#7DA1BE", "#393E42", "#F08544"))
  })
  
  points = reactive({
    type = function(selection){
      selection = as.integer(selection)
      switch(selection,
             "l", "p", "b", "n")
    }
    mapply(type, c(input$s1, input$s2, input$s3))
  })
  
  # Render line chart
  output$mychart <- renderLineChart({
    # Return a data frame. Each column will be a series in the line chart.
    df = data.frame(
      Sine = sin(1:100/10 + input$sinePhase * pi/180) * input$sineAmplitude,
      Cosine = 0.5 * cos(1:100/10),
      "Sine 2" = sin(1:100/10) * 0.25 + 0.5
    )

    return(list( data=df, 
                 ylim=input$ylimits, 
                 xlim=c(20,80), 
                 cols=colors(), 
                 xlim=input$xlimits, 
                 ylab=input$ylabel, 
                 xlab=input$xlabel,
                 type=points()
                 ))
  })
})
