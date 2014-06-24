# Shiny JavaScript examples

This repository contains examples of simple but nontrivial Shiny applications that demonstrate integration with custom JavaScript code.

## Output example

An adaptation of the [NVD3.js](http://nv3d.org/) charting library's [Simple Line Chart](http://nvd3.org/ghpages/line.html) example. Demonstrates creating a custom Shiny output binding that uses a JavaScript component.

Run this example by calling:

`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="output")`

## Input example

Demonstrates creating a custom Shiny input binding for a simple JavaScript-enabled "dueling select box" input widget.

Run this example by calling:

`shiny::runGitHub("shiny-js-examples", "dcurrier", subdir="input")`
