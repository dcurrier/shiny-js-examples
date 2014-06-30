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
    y = result$y
    
    # Assign settings to variables
    for(i in 1:length(result)){
      assign(names(result)[i], result[[i]])
    }
    
    if(is.null(y)){
      return()
    }else{
      # Return null if x exists, is not null, and is not the correct dimension
      if( exists('x') && !(is.null(x)) ){
        if(is.data.frame(y)){
          if(  (is.data.frame(x) && dim(x)[1] != dim(y)[1] && dim(x)[2] != dim(y)[2]) ){
            return()
          }
        }else if(is.vector(y)){
          if( (is.vector(x) && length(x) != dim(y)[1]) ){
            return()
          }
        }else{
          return()
        }
      }
      
      formatXCoordinates = function(x, y){
        if(is.data.frame(x) && dim(y)[2] == dim(x)[2] && all(names(x) != names(y))){
          colnames(x) = names(y)
        }else if(is.data.frame(x) && dim(y)[2] > dim(x)[2]){ # if x is smaller, repeat x until it is the same size as y
          while(dim(x)[2] < dim(y)[2]){
            x = cbind(x, x)
          }
          if(dim(x)[2] > dim(y)[2]){ # if x overflows y truncate to make it the same size
            x = x[, 1:dim(y)[2]]
            colnames(x) = names(y)
          }
        }else if(is.data.frame(x) && dim(y)[2] < dim(x)[2]){ # if x is a data.frame and it is bigger than y, truncate
          x = x[, 1:dim(y)[2]]
          colnames(x) = names(y)
        }else if(is.vector(x) && length(x) == dim(y)[1]){ # if x is a vector, make it a data.frame with repeating columns of x
          t = as.data.frame(matrix(nrow = dim(y)[1], ncol = 0))
          while(dim(t)[2] < dim(y)[2]){
            t = cbind(t, x)
          }
          x = t
          colnames(x) = names(y)
        }
        return(x)
      }
      
      # Ensure that column names are the same in both X and Y
      if(is.data.frame(y)){
        # If names have been specified, but the colnames of y are not named the same, make them the same
        if(exists('names') && length(names) == dim(y)[2] && all(names(y) != names)){
          colnames(y) = names
        }
        
        # If x is a data.frame and it is the same size as y and the names do not match, force them to match
        if(!(exists('x'))){
          x=1:nrow(y)
        }
        
        # Adjust X coordinates to match Y coordinates
        x = formatXCoordinates(x, y)  
      }else if(is.vector(y)){
        # Convert to Data.Frame
        y = as.data.frame(y)
        
        if(!(exists('x'))){
          x=1:nrow(y)
        }
        
        # Adjust X Coords
        x = formatXCoordinates(x, y)
      }
      
      # Convert colors to hex
      if( !(exists('cols')) || is.null(cols) || length(cols) != dim(y)[2] ) {
        if(!(exists('cols')) || is.null(cols)){
          # If colors were not supplied, construct a vector of null values
          cols = rep("", dim(y)[2])
        }else{
          # If the color vector supplied is not the correct length, make one that is by recycling/truncating as necessary
          cols = rep(cols, ceiling(dim(y)[2]/length(cols)))[1:dim(y)[2]]
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
      
      if( !(exists('size')) || is.null(size) || length(size) != dim(y)[2]) {
        if(!(exists('size')) || is.null(size)){
          # If colors were not supplied, construct a vector of null values
          size = rep("", dim(y)[2])
        }else{
          # If the color vector supplied is not the correct length, make one that is by recycling/truncating as necessary
          size = rep(size, ceiling(dim(y)[2]/length(size)))[1:dim(y)[2]]
        }
      }
      
      if( !(exists('shape')) || is.null(shape) || length(shape) != dim(y)[2]) {
        if(!(exists('shape')) || is.null(shape)){
          # If colors were not supplied, construct a vector of null values
          shape = rep("", dim(y)[2])
        }else{
          # If the color vector supplied is not the correct length, make one that is by recycling/truncating as necessary
          shape = rep(shape, ceiling(dim(y)[2]/length(shape)))[1:dim(y)[2]]
          if(any(shape != 'cirlce')){
            onlyCircles = FALSE
          }
        }
      }else{
        allowed = c('circle', 'cross', 'triangle-up', 'triangle-down', 'diamond', 'square')
        shape[which(!(shape %in% allowed))] = allowed[1]
        if(any(shape != 'cirlce')){
          onlyCircles = FALSE
        }
      }
      
     
      
      
      # Return the data and plot settings as a list
      c(list(
        data = mapply(function(col, name, color, size, shape) {
          
          values <- mapply(function(val, i, s, sh) {
              list(x = i, y = val, size = s, shape = sh)
          }, col, x[,which(names(x)==name)], size, shape, SIMPLIFY=FALSE, USE.NAMES=FALSE)
          
          list(key = name, values = values, color=color)
          
        }, y, names(y), cols, size, shape, SIMPLIFY=FALSE, USE.NAMES=FALSE)),
        mapply(function(setting){
          get(setting)
        },names(result)[which(names(result) != "data")])
      )
    }
  }
}