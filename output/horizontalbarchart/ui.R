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
             a(href="http://nvd3.org/examples/multiBarHorizontal.html", "Horizontal Bar Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=9,
           br(),
           div(h4("Breaks in Yarn During Weaving",
                  style ="text-align: center")),
           br(),
           horizontalBarChartOutput("myHorizontalBarChart", height=500)                    
    ),
    column(width=3,
           h4("Plotting Parameters"),
           selectInput("wool", label="Wool Type",
                       choices=c("Type A", "Type B")),
           hr(),
           sliderInput('xRange', label="X Axis Range", 0, 130, value=c(0, 70), step=5),
           checkboxInput('autoX', label="Auto Calculate X Axis Range", value=TRUE),
           hr(),
           h4("Show/Hide Values"),
           checkboxInput('values', label="Show Values", value=FALSE),
           checkboxInput('tool', label="Show Tooltips", value=TRUE),
           helpText("NOTE: To view Tooltips, hover over a bar on the graph."),
           hr(),
           h4("Color Scheme"),
           selectInput("colors", "Bar Color", 
                       choices=list("Default NVD3 Colors"=1, "Theme 800"=2, "Ice Road"=3, "Infinity8"=4))
           
    )
  )
))
