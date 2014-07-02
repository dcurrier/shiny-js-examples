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
             a(href="http://nvd3.org/examples/pie.html", "Pie Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=6,
           br(),
           div(h4("Pie Chart",
                  style ="text-align: center")),
           br(),
           pieChartOutput("myPieChart", height=500)                    
    ),
    column(width=6,
           br(),
           div(h4("Donut Chart",
                  style ="text-align: center")),
           br(),
           pieChartOutput("myDonutChart", height=500)                    
    )),
  fluidRow(
    column(width=3, offset=2,
           h4("Label Parameters"),
           numericInput('threshold', label="Label Threshold", value=0.01, min=0, max=1, step=0.01)
    ),
    column(width=3, offset=3,      
           h4("Donut Parameters"),
           numericInput('donutRatio', label="Hole Size", value=0.25, min=0, max=1, step=0.05)
    )
  )
))
