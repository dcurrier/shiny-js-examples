library(shiny)

# To be called from ui.R
discreteBarChartOutput <- function(inputId, width="100%", height="400px") {
  
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
      tags$script(src="discretebarchart-binding.js")
    )),
    div(id=inputId, class="nvd3-discretebarchart", style=style,
      tag("svg", list())
    )
  )
}

# To be called from server.R
renderDiscreteBarChart <- function(expr, env=parent.frame(), quoted=FALSE) {
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
      # Generate default name variable if one does not already exist
      if( !(exists('name')) || is.null(name) ){
        name = ""
      }
      
      
      # Return the data and plot settings as a list
      values <- mapply(function(l, v) {
        list(label = l, value = v)
      }, dataframe$label,  dataframe$value, SIMPLIFY=FALSE, USE.NAMES=FALSE)
      
      list(
        data = list(key = name, values = values),
        mapply(function(setting){
          get(setting)
        },names(result)[which(names(result) != "data")])
      )
    }
  }
}

