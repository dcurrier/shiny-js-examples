# Shiny JavaScript examples

This repository contains examples of simple but nontrivial Shiny applications that demonstrate integration with custom JavaScript code.

## Output examples

Adaptation of [NVD3.js](http://nv3d.org/) charting library's examples. Extends [This Example](http://github.com/jcheng5/shiny-js-examples) by adding customizable chart elements and building outputs for additional chart types.  Currently supported are [Line Chart](http://nvd3.org/examples/line.html), [Line With Focus Chart](http://nvd3.org/examples/lineWithFocus.html), [Scatter Chart](http://nvd3.org/examples/scatter.html), [Discrete Bar Chart](http://nvd3.org/examples/discreteBar.html), and [Multi-Bar Chart](http://nvd3.org/examples/multibar.html).

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


Or, if you do not have R or the Shiny package installed, the following links will bring you to examples hosted by [shinyapps.io](http://www.shinyapps.io).

[Line Chart Output](http://dcurrier.shinyapps.io/shiny-js-linechart)

[Line With Focus Output](http://dcurrier.shinyapps.io/shiny-js-linewihtfocus)

[Multi Bar Chart Output](http://dcurrier.shinyapps.io/shiny-js-multibarchart)

[Discrete Bar Chart](http://dcurrier.shinyapps.io/discretebarchart)

[Scatter Chart](http://dcurrier.shinyapps.io/shiny-js-scatterchart)



## Input example

Demonstrates creating a custom Shiny input binding for a simple JavaScript-enabled "dueling select box" input widget.

Run this example by calling:

`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="input")`
