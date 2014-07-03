library(shiny)

# To be called from ui.R
horizontalBarChartOutput <- function(inputId, width="100%", height="400px") {
  
  style <- sprintf("width: %s; height: %s;",
    validateCssUnit(width), validateCssUnit(height))
  
  tagList(
    # Include CSS/JS dependencies. Use "singleton" to make sure that even
    # if multiple lineChartOutputs are used in the same page, we'll still
    # only include these chunks once.
    singleton(tags$head(
      tags$script(src="d3/d3.v3.min.js"),
      tags$script(src="nvd3/nv.d3.min.js"),
      tags$link(rel="stylesheet", type="text/css", href="nvd3/nv.d3.min.css"),
      tags$script(src="horizontalbarchart-binding.js")
    )),
    div(id=inputId, class="nvd3-horizontalbarchart", style=style,
      tag("svg", list())
    )
  )
}

# To be called from server.R
renderHorizontalBarChart <- function(expr, env=parent.frame(), quoted=FALSE) {
  # This piece of boilerplate converts the expression `expr` into a
  # function called `func`. It's needed for the RStudio IDE's built-in
  # debugger to work properly on the expression.
  installExprFunction(expr, "func", env, quoted)
  
  function() {
    result <- func()
    dataframe = result$data
    
    # Assign settings to variables
    for(i in 1:length(result)){
      assign(names(result)[i], result[[i]])
    }
    
    if(is.null(dataframe)){
      return()
    }else{
      # Validate structure of dataframe
      if( !('label' %in% colnames(dataframe)) ){
        colnames(dataframe) = c( 'label', colnames(dataframe)[2:length(colnames(dataframe))])
      }
      
      # Generate default name variable if one does not already exist
      if( !(exists('seriesNames')) || is.null(seriesNames) ){
        seriesNames = colnames(dataframe)[which(colnames(dataframe) != 'label')]
      }else{
        if( length(seriesNames) > dim(dataframe)[2]-1 ){
          seriesNames = seriesNames[1:dim(dataframe)[2]-1]
        }
        if( length(seriesNames) < dim(dataframe)[2]-1 ){
          seriesNames = rep(seriesNames, ceiling(dim(dataframe)[2]-1/length(seriesNames)))[1:dim(dataframe)[2]-1]
        }
      }
      
      # Generate color vector if not supplied
      if( !(exists('cols')) || is.null(cols) ){
        cols = rep("", dim(dataframe)[2]-1)
      }else{
        # If too many colors were supplied, truncate
        if( length(cols) > length(dataframe$value) ){
          cols = cols[1:dim(dataframe)[2]-1]
        }
        # If too few colors were supplied, repeat as necessary
        if( length(cols) < dim(dataframe)[2]-1 ){
          cols = rep(cols, ceiling(dim(dataframe)[2]-1/length(cols)))[1:dim(dataframe)[2]-1]
        }
        # Convert supplied colors to Hex format
        cols = unlist(mapply(function(c){
          c = unlist(c)
          if(is.numeric(c) && length(c) == 3){
            r = c[1]
            g = c[2]
            b = c[3]
            if(max(c) <= 1){ m = 1 }else{ m = 255 }
            rgb(r,g,b,max=m)
          }else if(is.character(c) && c == ""){ 
            return("") 
          }else if(strsplit(c, "")[1] != "#" && is.character(c) && c %in% colors() ){
            rgb(t(col2rgb(c)), max=255)
          }else{
            if(nchar(c)>7){
              return(strtrim(c, 7))
            }else{
              return(c)
            }
          }
        }, cols))
      }
      cols = unname(cols)
      
      
      # Return the data and plot settings as a list
      
      
      c(list(
        data = mapply(function( values, name, col) {
          
          values <- mapply(function(l, v) {
            list(label = l, value = v)
          }, dataframe$label,  as.numeric(values), SIMPLIFY=FALSE, USE.NAMES=FALSE)
          
          list(key = name, color = col, values = values)
        }, dataframe[, which(colnames(dataframe) != 'label')], 
           seriesNames, 
           cols, SIMPLIFY=FALSE, USE.NAMES=FALSE)
          
           ),
        mapply(function(setting){
          get(setting)
        },names(result)[which(names(result) != "data")])
      )
      

    }
  }
}

