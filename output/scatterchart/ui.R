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
             a(href="http://nvd3.org/examples/scatter.html", "Scatter Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=9,
           br(),
           div(h4("Interactive Scatter Plot of Random Numbers",
                  style ="text-align: center")),
           br(),
           scatterChartOutput("myScatterChart", height=500),
           br(),
           hr(),
           fluidRow(
             column(width=4,
                    h4("Color Scheme:"),
                    selectInput("colors", "Line Colors", 
                                choices=list("Default NVD3 Colors"=1, "Theme 800"=2, "Ice Road"=3, "Infinity8"=4))
             ),
             column(width=4,
                    h4("Show Distributions:"),
                    fluidRow(
                      column(width=6,
                             radioButtons("xDist", label = "X Axis",
                                          choices = list("On" = 1, "Off" = 0), 
                                          selected = 1)),
                      column(width=6,
                             radioButtons("yDist", label = "Y Axis",
                                          choices = list("On" = 1, "Off" = 0), 
                                          selected = 1))
                      )),
             column(width=4,
                    h4("Parameter")
             )
             )
    ),
    column(width=3,
           sliderInput("n", "Number of Obs", 0, 100, 25, step=5),
           h4("Group 1:"),
           sliderInput("g1Yr", "Y Range", 100, 1000, c(400, 500), step=10),
           sliderInput("g1Xr", "X Range", 100, 1000, c(700, 900), step=10),
           sliderInput("g1sz", "Point Size", 1, 10, 5, step=1),
           hr(),
           h4("Group 2:"),
           sliderInput("g2Yr", "Y Range", 100, 1000, c(200, 300), step=10),
           sliderInput("g2Xr", "X Range", 100, 1000, c(500, 900), step=10),
           sliderInput("g2sz", "Point Size", 1, 10, 5, step=1),
           hr(),
           h4("Group 3:"),
           sliderInput("g3Yr", "Y Range", 100, 1000, c(700, 800), step=10),
           sliderInput("g3Xr", "X Range", 100, 1000, c(250, 400), step=10),
           sliderInput("g3sz", "Point Size", 1, 10, 5, step=1)
    )
  )
))
