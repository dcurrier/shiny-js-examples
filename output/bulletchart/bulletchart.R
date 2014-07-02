library(shiny)

# To be called from ui.R
bulletChartOutput <- function(inputId, width="100%", height="100px") {
  
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
      tags$script(src="bulletchart-binding.js")
    )),
    div(id=inputId, class="nvd3-bulletchart", style=style,
        tag("svg", list())
    )
  )
}

# To be called from server.R
renderBulletChart <- function(expr, env=parent.frame(), quoted=FALSE) {
  # This piece of boilerplate converts the expression `expr` into a
  # function called `func`. It's needed for the RStudio IDE's built-in
  # debugger to work properly on the expression.
  installExprFunction(expr, "func", env, quoted)
  
  function() {
    result <- func()
    data = result$data
    
    # Assign settings to variables
    for(i in 1:length(result)){
      assign(names(result)[i], result[[i]])
    }
    
    if(is.null(data) || !(is.list(data)) ){
      return()
    }else{
      ### Fix Data input issues
      # Return null if any of the data fields are left empty
      if( is.null(data$ranges) || is.null(data$measures) ){
        return()
      }
      
      # Return an empty string if the title is left blank
      if( is.null(data$title) ){
        data$title = ""
      }
      
      # Return an empty string if the subtite is left blank
      if( is.null(data$subtitle) ){
        data$subtitle = ""
      }
      
      
      ### Convert settings to proper formats
      # Convert colors to hex
      if( !(exists('cols')) || is.null(cols) ) {
        if(!(exists('cols')) || is.null(cols)){
          # If colors were not supplied, construct a vector of null values
          cols = ""
        }
      } else {
        if( length(cols) > 1 ){
          cols = cols[1]
        }
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
      cols = unname(cols)
      
      # Return the data and plot settings as a list
      c(list(
        data = list(  title=data$title, 
                      subtitle=data$subtitle,
                      ranges = unlist(data$ranges, recursive=FALSE),
                      measures = list(data$measures),
                      markers = list(data$markers),
                      rangeLabels = unlist(data$rangeLabels, recursive=FALSE),
                      measureLabels = list(data$measureLabels),
                      markerLabels = list(data$markerLabels)
                      )),
        mapply(function(setting){
          get(setting)
        },names(result)[which(names(result) != "data")])
      )
    }
  }
}