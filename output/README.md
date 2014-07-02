# Output example

Adaptation of [NVD3.js](http://nv3d.org/) charting library's examples. Extends [This Example](http://github.com/jcheng5/shiny-js-examples) by adding customizable chart elements and building outputs for additional chart types.  Currently supported are [Line Chart](http://nvd3.org/examples/line.html), [Line With Focus Chart](http://nvd3.org/examples/lineWithFocus.html), [Scatter Chart](http://nvd3.org/examples/scatter.html), [Discrete Bar Chart](http://nvd3.org/examples/discreteBar.html), [Multi-Bar Chart](http://nvd3.org/examples/multibar.html), and [Bullet Chart](http://nvd3.org/examples/bullet.html).

Run these examples by calling:

Line Chart:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/linechart", launch.browser=TRUE)`

Line With Focus:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/linewithfocuschart", launch.browser=TRUE)`

Multi Bar Chart:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/multibarchart", launch.browser=TRUE)`

Discrete Bar Chart Output:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/discretebarchart", launch.browser=TRUE)`

Scatter Chart:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/scatterchart", launch.browser=TRUE)`

Bullet Chart:
`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output/bulletchart", launch.browser=TRUE)`


Or, if you do not have R or the Shiny package installed, the following links will bring you to examples hosted by [shinyapps.io](http://www.shinyapps.io).

[Line Chart Output](http://dcurrier.shinyapps.io/shiny-js-linechart)

[Line With Focus Output](http://dcurrier.shinyapps.io/shiny-js-linewihtfocus)

[Multi Bar Chart Output](http://dcurrier.shinyapps.io/shiny-js-multibarchart)

[Discrete Bar Chart](http://dcurrier.shinyapps.io/discretebarchart)

[Scatter Chart](http://dcurrier.shinyapps.io/shiny-js-scatterchart)

[Bullet Chart](http://dcurrier.shinyapps.io/bulletchart)



## Implementation

Using linechart as an example, `linechart.R` contains reusable R functions `lineChartOutput` and `renderLineChart` that can be called from a Shiny app's `ui.R` and `server.R` (respectively) to add line charts.

The file `www/linechart-binding.js` contains the JavaScript code that defines a custom Shiny output binding for the line charts. It's loaded into the app implicitly by the `lineChartOutput` function.

The `www/d3` and `www/nvd3` directories contain the 3rd party libraries [D3](http://d3js.org/) and [NVD3](http://nvd3.org/). They also are loaded from `lineChartOutput`.

The other outputs are assembled in the same way; look for `chartType.R` and `www/chartType-binding.js`.  Also check out [ShinyNVD3](http://github.com/dcurrier/ShinyNVD3) for progress on an R package containing these outputs.


## Packaging note

This example is set up for easy reading of the code and easy running via `shiny::runGitHub()`.  For the R Package containing these outputs go to [ShinyNVD3](http://github.com/dcurrier/ShinyNVD3).
