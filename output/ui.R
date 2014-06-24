shinyUI(fluidPage(
  tags$h2("JavaScript output binding example"),
  fluidRow(
    column(width=6,
      p("This Shiny app is an adaptation of the",
        a(href="http://nvd3.org/examples/line.html", "Simple Line Chart"),
        "example for the",
        a(href="http://nvd3.org/", "NVD3.js"),
        "JavaScript charting library."
      ),
      p("Source code:",
        a(href="https://github.com/jcheng5/shiny-js-examples/tree/master/output", "@jcheng5/shiny-js-examples/output"))
    )
  ),
  fluidRow(
    column(width=9,
      lineChartOutput("mychart")
    ),
    column(width=3,
      sliderInput("sinePhase", "Sine phase", -180, 180, 0, step=10,
        animate=animationOptions(interval=100, loop=TRUE)),
      sliderInput("sineAmplitude", "Sine amplitude", -2, 2, 1, step=0.1,
        animate=animationOptions(interval=100, loop=TRUE)),
      sliderInput("xlimits", "X-Axis Limits", 1, 100, c(20, 80)),
      sliderInput("ylimits", "Y-Axis Limits", -5, 5, c(-1, 1)),
      selectInput("colors", "Line Colors", 
                  choices=list("Default NVD3 Colors"=1, "Theme 800"=2, "Ice Road"=3, "Infinity8"=4),
                  selected = 1),
      textInput("xlabel", label="X-Axis Label", value="Time (ms)"),
      textInput("ylabel", label="Y-Axis Label", value="Voltage (v)")
    )
  )
))
