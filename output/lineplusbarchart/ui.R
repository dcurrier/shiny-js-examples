shinyUI(fluidPage(
  tags$h2("JavaScript Output Binding Examples - NVD3 Graphs"),
  fluidRow(
    column(width=6,
      p("Source code:",
        a(href="https://github.com/dcurrier/shiny-js-examples/tree/master/output", "@dcurrier/shiny-js-examples/output"))
    )
  ),
  fluidRow(
    column(width=12,
           p("This Shiny app is an adaptation of the",
             a(href="http://nvd3.org/examples/line.html", "Simple Line Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=9,
           br(),
           div(h4("Old Faithful Eruptions",
                  style ="text-align: center")),
           br(),
           linePlusBarChartOutput("myLinePlusBarChart", height=500)                    
    ),
    column(width=3,
           h4("Params")
           
           
    )
  )
  
))
