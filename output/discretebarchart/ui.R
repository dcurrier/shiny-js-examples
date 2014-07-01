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
             a(href="http://nvd3.org/examples/discreteBar.html", "Discrete Bar Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=9,
           br(),
           div(h4("Discrete Bar Chart",
                  style ="text-align: center")),
           br(),
           discreteBarChartOutput("myDiscreteBarChart", height=500)                    
    ),
    column(width=3,
           h4("Data Values:"),
           sliderInput("a", "A", -20, 180, 5, step=0.01),
           sliderInput("b", "B", -20, 180, 25, step=0.01),
           sliderInput("c", "C", -20, 180, 175, step=0.01),
           sliderInput("d", "D", -20, 180, 60, step=0.01),
           sliderInput("e", "E", -20, 180, 90, step=0.01),
           sliderInput("f", "F", -20, 180, -10, step=0.01),
           sliderInput("g", "G", -20, 180, 125, step=0.01),
           hr(),
           h4("X Axis Parameters"),
           sliderInput("xlimits", "X-Axis Limits", 1, 100, c(20, 80)),
           textInput("xlabel", label="X-Axis Label", value="Time (ms)"),
           hr(),
           h4("Y Axis Parameters"),
           textInput("ylabel", label="Y-Axis Label", value="Voltage (v)"),
           sliderInput("ylimits", "Y-Axis Limits", -5, 5, c(-1, 1))
           
    )
  )
))
