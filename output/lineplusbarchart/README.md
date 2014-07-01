# Output example

An adaptation of [NVD3.js](http://nv3d.org/) charting library's [Line Plus Bar Chart](http://nvd3.org/examples/linePlusBar.html) example. Extends [This Example](http://github.com/jcheng5/shiny-js-examples) by adding customizable chart elements.

Run this example by calling:

Line Chart Output:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/lineplusbarchart", launch.browser=TRUE)`

Or, if you do not have R or the Shiny package installed, the following links will bring you to examples hosted by [shinyapps.io](http://www.shinyapps.io).

[Line Plus Bar Chart Output](http://dcurrier.shinyapps.io/lineplusbarchart)


## Implementation

`lineplusbarchart.R` contains reusable R functions `linePlusBarChartOutput` and `renderLinePlusBarChart` that can be called from a Shiny app's `ui.R` and `server.R` (respectively) to add line charts.

The file `www/lineplusbarchart-binding.js` contains the JavaScript code that defines a custom Shiny output binding for the line charts. It's loaded into the app implicitly by the `linePlusBarChartOutput` function.

The `www/d3` and `www/nvd3` directories contain the 3rd party libraries [D3](http://d3js.org/) and [NVD3](http://nvd3.org/). They also are loaded from `linePlusBarChartOutput`.


## Packaging note

This example is set up for easy reading of the code and easy running via `shiny::runGitHub()`.  For the R Package containing this and other outputs go to [ShinyNVD3](http://github.com/dcurrier/ShinyNVD3).
