shinyServer(function(input, output, session) {
  
  ############################################
  # HorizontalBarChart
  
  data = reactive({
    d = datasets::warpbreaks
    
    s = d[which(d$wool == strsplit(input$wool, " ")[[1]][2]),]
    tens = unique(d$tension)
    
    cond = as.data.frame(matrix(NA, nrow=9, ncol=4))
    
    for( i in 1:9 ) {    
      cond[i, ] = c(paste("Test ", LETTERS[i], sep = ""), 
                    s[which(s$tension == "L"), 'breaks'][i],
                    s[which(s$tension == "M"), 'breaks'][i],
                    s[which(s$tension == "H"), 'breaks'][i] )  
    }
    
    colnames(cond) = c("Label", "L", "M", "H")
    
    return(cond)
    
  })
  
  
  
  # Return colors from color scheme chosen
  colors = reactive({
    choice = as.integer(input$colors)
    switch(choice,
           c("", "", ""),
           c("#39BF73", "#F27507", "#BF190A"),
           c("#123E59", "#20788C", "#BFB7B0"),
           c("#7DA1BE", "#393E42", "#F08544"))
  })
  
  
  
  # Render Horizontal chart
  output$myHorizontalBarChart <- renderHorizontalBarChart({
    # Return a data frame. Each column will be a series in the line chart.
   
    return(list( data=data(),
                 xlab="Number of Breaks",
                 xlim=if(input$autoX){NULL}else{input$xRange},
                 mar=c(30, 20, 50, 100),
                 showTooltip = input$tool,
                 showValues = input$values,
                 cols=colors(),
                 seriesNames=c("Low Tension", "Med Tension", "High Tension"),
                 showControls=TRUE
                 ))
  })
  
  # End HorizontalBarChart
  ############################################
  
  
  
})
