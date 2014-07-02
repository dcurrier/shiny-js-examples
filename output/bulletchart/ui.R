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
             a(href="http://nvd3.org/examples/bullet.html", "Bullet Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=12,
           br(),
           div(h4("Interactive Bullet Chart",
                  style ="text-align: center")),
           br(),
           bulletChartOutput("myBulletChart", height=100)

           
    )),
  fluidRow(
    column(width=3,
           h4("Range"),
           sliderInput("range", label="Minimum/Maximum", 0, 1000, 
                       value=c(300, 500)),
           br(),
           h4("Mean"),
           sliderInput("mean", label="Mean", 0, 1000, 
                       value=400)     
    ),
    column(width=3,
           h4("Range Labels"),
           textInput("min", label="Range Minimum", value="Minimum"),
           textInput("int", label="Range Intermediate", value="Mean"),
           textInput("max", label="Range Maximum", value="Maximum")
    ),
    column(width=3,
           h4("Measure"),
           sliderInput("meas", label="Measure", 0, 1000, 
                       value=350),
           br(),
           h4("Color"),
           selectInput("colors", label="Measure Color", 
                       choices = list("Default"=1, "Purple"=2, "Red"=3,
                                      "Green"=4, "Orange"=5, "Black"=6),
                       selected=1)
    ),
    column(width=3,
           h4("Marker"),
           sliderInput("mark", label="Marker", 0, 1000, 
                       value=450),
           br(),
           helpText("Markers can be statically shown or not.  If shown on 
                    the chart, they can be removed, but not re-displayed."),
           actionButton("markToggle", label="Remove Marker")
    ))
    
))
