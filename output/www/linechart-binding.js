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
  return $(scope).find(".nvd3-linechart");
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
  
  // Generate x Axis label
  if (typeof input.xlab != 'undefined' || input.xlab != null) {
    var xlabel = input.xlab;
  }else{
    var xlabel = " ";
  }
  
  // store xDomain if applicable
  if (typeof input.xlim != 'undefined' || input.xlim != null) {
    var xDomain = input.xlim;
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
  
  var $el = $(el);
    
  // The first time we render a value for a particular element, we
  // need to initialize the nvd3 line chart and d3 selection. We'll
  // store these on $el as a data value called "state".
  if (!$el.data("state")) {
    var chart = nv.models.lineChart()
      .margin({left: 100})
      .useInteractiveGuideline(true)
      .transitionDuration(350)
      .showLegend(true)
      .showYAxis(true)
      .showXAxis(true);
      
    chart.xAxis     //Chart x-axis settings
      .axisLabel('Time (ms)')
      .tickFormat(d3.format(',r'));
      
    // Apply xDomain if applicable
    if (typeof xDomain != 'undefined') {
      chart.xDomain(xDomain);
    }
 
    chart.yAxis     //Chart y-axis settings
      .axisLabel('Voltage (v)')
      .tickFormat(d3.format('.02f'));

    // Apply yDomain if applicable
    if (typeof yDomain != 'undefined') {
      chart.yDomain(yDomain);
    }

    // Moved this down to the nv.addGraph function
    //nv.utils.windowResize(chart.update);
    
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
      .yDomain(yDomain)
      .xDomain(xDomain);
    state.selection
      .datum(input.data)
      .transition(500)
      .call(state.chart);
    
    nv.utils.windowResize(state.chart.update); // chart was not updating on windowResize until I put this here
    
    return state.chart;
  });
};

// Tell Shiny about our new output binding
Shiny.outputBindings.register(binding, "shinyjsexamples.nvd3-linechart");

})();
