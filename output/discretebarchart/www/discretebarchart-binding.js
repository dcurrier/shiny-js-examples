// Put code in an Immediately Invoked Function Expression (IIFE).
// This isn't strictly necessary, but it's good JavaScript hygiene.
(function() {

// See http://rstudio.github.io/shiny/tutorial/#building-outputs for
// more information on creating output bindings.

// First create a generic output binding instance, then overwrite
// specific methods whose behavior we want to change.
var binding = new Shiny.OutputBinding();

binding.find = function(scope) {
  // For the given scope, return the set of elements that belong to
  // this binding.
  return $(scope).find(".nvd3-discretebarchart");
};

binding.renderValue = function(el, input) {
  // This function will be called every time we receive new output
  // values for a line chart from Shiny. The "el" argument is the
  // div for this particular chart.
  console.debug(input);
  
  if(input == null){
    return;
  }
  
  
  // We need to store these variables before rendering the chart, so 
  // that we can access them again when they are updated by reactive
  // elements
  
  // Create Margin object -- NOTE: Top margin will always be reset to the legend height!
  if(typeof input.mar != 'undefined' && input.mar.length == 4){
    var mar = {top: input.mar[0], right: input.mar[1], bottom: input.mar[2], left: input.mar[3]};
  }else{
    var mar = {top: 30, right: 20, bottom: 50, left: 100};
  }
  
  // Generate x Axis label
  if (typeof input.xlab != 'undefined' || input.xlab != null) {
    var xlabel = input.xlab;
  }else{
    var xlabel = " ";
  }
  
  // Generate y Axis label
  if (typeof input.ylab != 'undefined') {
    var ylabel = input.ylab;
  }else{
    var ylabel = " ";
  }
  
  // Apply yDomain if applicable
  if (typeof input.ylim != 'undefined') {
    var yDomain = input.ylim;
  }
  
  // Apply title is applicable  -- Titles will not be supported until the top margin bug is fixed
  /*if(typeof input.main != 'undefined') {
    var title = input.main;
    //mar.top = 100;  // The top margin is reset to the legend height - it's a bug that won't be fixed until v2.0.0
  }*/

  var $el = $(el);
    
  // The first time we render a value for a particular element, we
  // need to initialize the nvd3 line chart and d3 selection. We'll
  // store these on $el as a data value called "state".
  if (!$el.data("state")) {
    var chart =nv.models.discreteBarChart()
      .margin(mar)
      .x(function(d) { return d.label })
      .y(function(d) { return d.value })
      .staggerLabels(false)
      .tooltips(false)
      .showValues(true);
    
    chart.xAxis     //Chart x-axis settings
      .axisLabel(xlabel); 
 
    chart.yAxis     //Chart y-axis settings
      .axisLabel(ylabel)
      .tickFormat(d3.format('f'));  // See https://github.com/mbostock/d3/wiki/Formatting for formatting codes

    // Apply yDomain if applicable
    if (typeof yDomain != 'undefined') {
      chart.yDomain(yDomain);
    }
    
    
    var selection = d3.select(el).select("svg");
    
    // Store the chart object on el so we can get it next time
    $el.data("state", {
      chart: chart,
      selection: selection
    });
    
  }
  
  // Now, the code that'll run every time a value is rendered...
  
  // Retrieve the chart and selection we created earlier
  var state = $el.data("state");
  
  
  // Schedule some work with nvd3
  nv.addGraph(function() {
    // Update the chart
    state.chart
      .yDomain(yDomain) // Sets Axis domain, but negative bars are not rendered correctly.
      .yAxis.axisLabel(ylabel);
    state.chart
      .xAxis.axisLabel(xlabel);
    state.selection
      .datum(input.data)
      .transition(500)
      .call(state.chart);
    
    
    // chart was not updating on windowResize until I put this here
    // mkpoints needs to be called on updates to reset the css properties
    nv.utils.windowResize(function(){
                            state.chart.update();                
      });
    
    return state.chart;
  });
  
  
};



// Tell Shiny about our new output binding
Shiny.outputBindings.register(binding, "shinyjsexamples.nvd3-discretebarchart");

})();
