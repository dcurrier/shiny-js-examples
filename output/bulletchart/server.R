shinyServer(function(input, output, session) {
  
  
  
  ############################################
  # Bullet Chart
  
  # Return colors from color scheme chosen
  colors = reactive({
    choice = as.integer(input$colors)
    switch(choice,
           NULL,
           "#32192E",
           "#E0393D",
           "#4EB200", 
           "#B26400", 
           "#000000")
  })
  
  marker = reactive({
    if(input$markToggle == 0){
      input$mark
    }else{
      NULL
    }
  })
  
  
  # Render line chart
  output$myBulletChart <- renderBulletChart({
    # Return a list with names elements as such
    list( data = list(                                # Agregate the elements into a list so it is easier to add settings later  
                    title = "Fixed Title",  	            # Label the bullet chart
                    subtitle = "Fixed Subtitle",		# sub-label for bullet chart
                    ranges = list(c(input$range[1],input$mean,input$range[2])),	        # Minimum, mean and maximum values.
                    measures = input$meas,		                # Value representing current measurement (the thick blue line in the example)
                    markers = marker(),		                  # Triangle Marker Positions
                    rangeLabels = list(c(input$max,input$int,input$min)),
                    measureLabels = "Measure",
                    markerLabels = "Marker"                    
                    ),
          cols = colors()
    )
    
  })
  
  
  
  
  
})
