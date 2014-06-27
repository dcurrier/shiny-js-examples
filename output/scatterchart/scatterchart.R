library(shiny)

# To be called from ui.R
scatterChartOutput <- function(inputId, width="100%", height="400px") {
  
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
      tags$script(src="scatterchart-binding.js")
    )),
    div(id=inputId, class="nvd3-scatterchart", style=style,
        tag("svg", list())
    )
  )
}

# To be called from server.R
renderScatterChart <- function(expr, env=parent.frame(), quoted=FALSE) {
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
      # Convert colors to hex
      if( !(exists('cols')) || is.null(cols) || length(cols) != dim(dataframe)[2] ) {
        if(!(exists('cols')) || is.null(cols)){
          # If colors were not supplied, construct a vector of null values
          cols = rep("", dim(dataframe)[2])
        }else{
          # If the color vector supplied is not the correct length, make one that is by recycling/truncating as necessary
          cols = rep(cols, ceiling(dim(dataframe)[2]/length(cols)))[1:dim(dataframe)[2]]
        }
      } else {
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
            return(c)
          }
        }, cols))
      }
      
      # Setup default plot style
      if( !(exists('type')) || is.null(type) || length(type) != dim(dataframe)[2] ) {
        if( !(exists('type')) || is.null(type) ) {
          # If the types were not supplied construct a vector of "l"s
          type = rep("l", dim(dataframe)[2])
        }else{
          # If the type vector supplied is not the correct length, make one that is by filling missing types with "l" or truncating
          if(length(type) > dim(dataframe)[2] ){
            type = type[1:dim(dataframe)[2]]
          }
          if(length(type) < dim(dataframe)[2] ) {
            type = c(type, rep("l", dim(dataframe)[2]-length(type)))
          }
        }
      }
      # remove any names attribute
      type = unname(type)
      
      # truncate data if xlim is narrower than data
      if(any(c('x', 'X') %in% colnames(dataframe))){
        xVals = data[,which(colnames(dataframe) %in% c('x', 'X'))]
      }else{
        xVals = 1:nrow(dataframe)
      }
      
      if(exists('xlim')){
        if(xlim[1] > min(xVals)){lower = min(which(xVals >= xlim[1]))}else{lower = which(xVals == min(xVals))}
        if(xlim[2] < max(xVals)){upper = max(which(xVals <= xlim[2]))}else{upper = which(xVals == max(xVals))}
        dataframe = dataframe[lower:upper, ]
        if(nrow(dataframe) < length(xVals)){
          #rm(xlim)
          result$xlim = NULL
        }
        xVals = xVals[lower:upper]
      }
      
      # Return the data and plot settings as a list
      c(list(
        data = mapply(function(col, name, color, type) {
          
          values <- mapply(function(val, i, t) {
            if(t == "p"){
              list(x = i, y = val, shape="square")
            }else{
              list(x = i, y = val)
            }
          }, col, xVals, type, SIMPLIFY=FALSE, USE.NAMES=FALSE)
          
          list(key = name, values = values, color=color)
          
        }, dataframe, names(dataframe), cols, type, SIMPLIFY=FALSE, USE.NAMES=FALSE)),
        mapply(function(setting){
          get(setting)
        },names(result)[which(names(result) != "data")])
      )
    }
  }
}