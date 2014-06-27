shinyUI(fluidPage(
  tags$h2("JavaScript Output Binding Examples - NVD3 Graphs"),
  fluidRow(
    column(width=6,
      p("Source code:",
        a(href="https://github.com/dcurrier/shiny-js-examples/tree/master/output", "@dcurrier/shiny-js-examples/output"))
    )
  ),
  tabsetPanel(
    tabPanel("Line Chart",
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
                      div(h4("Interactive Sine Curves",
                             style ="text-align: center")),
                      br(),
                      lineChartOutput("mychart", height=500)                    
               ),
               column(width=3,
                      h4("Curve Shapes:"),
                      sliderInput("sinePhase", "Sine phase", -180, 180, 0, step=10,
                                  animate=animationOptions(interval=100, loop=TRUE)),
                      sliderInput("sineAmplitude", "Sine amplitude", -2, 2, 1, step=0.1,
                                  animate=animationOptions(interval=100, loop=TRUE)),
                      hr(),
                      h4("X Axis Parameters"),
                      sliderInput("xlimits", "X-Axis Limits", 1, 100, c(20, 80)),
                      textInput("xlabel", label="X-Axis Label", value="Time (ms)"),
                      hr(),
                      h4("Y Axis Parameters"),
                      textInput("ylabel", label="Y-Axis Label", value="Voltage (v)"),
                      sliderInput("ylimits", "Y-Axis Limits", -5, 5, c(-1, 1))
                      
               )
             ),
             hr(),
             fluidRow(
               column(width=9,
                      div(h4("Plotting Styles:"), style="width: 80%"),
                      fluidRow(
                        column(width=4,
                               selectInput("s1", "Series 1 Plot Type", 
                                           choices=list("Line"=1, "Points"=2, "Both"=3, "None"=4),
                                           selected = 2)
                        ),
                        column(width=4,
                               selectInput("s2", "Series 2 Plot Type", 
                                           choices=list("Line"=1, "Points"=2, "Both"=3, "None"=4),
                                           selected = 1)
                        ),
                        column(width=4,
                               selectInput("s3", "Series 3 Plot Type", 
                                           choices=list("Line"=1, "Points"=2, "Both"=3, "None"=4),
                                           selected = 3)
                        )
                      )),
               column(width=3,
                      div(h4("Color Scheme:"), style="width: 80%"),
                      selectInput("colors", "Line Colors", 
                                  choices=list("Default NVD3 Colors"=1, "Theme 800"=2, "Ice Road"=3, "Infinity8"=4))
               )
             )),
    tabPanel("Scatter Chart",
             fluidRow())
  )
))
