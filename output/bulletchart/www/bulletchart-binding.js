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
  return $(scope).find(".nvd3-bulletchart");
};

binding.renderValue = function(el, input) {
  // This function will be called every time we receive new output
  // values for a line chart from Shiny. The "el" argument is the
  // div for this particular chart.
  console.debug(input);
  
  if(input == null){
    return;
  }
  
  
  
  var $el = $(el);
    
  // The first time we render a value for a particular element, we
  // need to initialize the nvd3 line chart and d3 selection. We'll
  // store these on $el as a data value called "state".
  if (!$el.data("state")) {
    var chart = nv.models.bulletChart();
    
    // Set color
    if (typeof input.cols != 'undefined' && input.cols != "") {
        chart.bullet.color(input.cols);
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
    // Set color
    if (typeof input.cols != 'undefined' && input.cols != "") {
        state.chart.bullet.color(input.cols);
    }
    
    // Update the chart
    state.selection
      .datum(input.data)
      .transition().duration(500)
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
Shiny.outputBindings.register(binding, "shinyjsexamples.nvd3-bulletchart");

})();
