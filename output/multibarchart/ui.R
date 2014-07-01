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
             a(href="http://nvd3.org/examples/multiBar.html", "Multi Bar Chart"),
             "example for the",
             a(href="http://nvd3.org/", "NVD3.js"),
             "JavaScript charting library."
           )
    )),             
  fluidRow(
    column(width=9,
           br(),
           div(h4("Airline Passengers",
                  style ="text-align: center")),
           br(),
           multiBarChartOutput("myMultiBarChart", height=500)                    
    ),
    column(width=3,
           h4("Color Scheme"),
           selectInput("colors", label="Plot Colors", 
                       choices=list("Default"=1, "Cyan-Magenta"=2, "Topo"=3, "Terrain"=4, "Heat"=5, "Rainbow"=6), 
                       selected=1),
           h4("X Axis Parameters"),
           textInput("xlabel", label="X-Axis Label", value="Year"),
           sliderInput("xlimits", "X-Axis Limits", 1949, 1960, c(1949, 1960), step=1, format="###0."),
           hr(),
           h4("Y Axis Parameters"),
           textInput("ylabel", label="Y-Axis Label", value="Number of Passengers [in Thousands]"),
           checkboxInput("autoY", label = "Auto Adjust Y-Axis", value = TRUE),
           sliderInput("ylimits", "Y-Axis Limits", 0, 800, c(0, 650))
    )
  )
))
