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
  return $(scope).find(".nvd3-piechart");
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
  
  // Set up Label Threshold Value
  if(typeof input.labelThreshold != 'undefined'){
    var labelTheshold = input.labelThreshold;
  }else{
    var labelTheshold = 0.05;
  }
  
  // Set up Show Label Values
  if(typeof input.showLabel != 'undefined') {
    var showLabels = Boolean(input.showLabels);
  }else{
    var showLabels = true;
  }
  
  // Set up Tool Tips Show
  if( typeof input.showTooltips != 'undefined' ){
    var showTooltips = Boolean(input.showTooltips);
  }else{
    var showTooltips = true;
  }
  
  // Set up label type
  if( typeof input.labelType != 'undefined' ){
    if( input.labelType.indexOf('key') >= 0 ||
        input.labelType.indexOf('value') >= 0 ||
        input.labelType.indexOf('percent') >= 0 ) {
          var labelType = input.labelType;
        }else{
          var labelType = "key";
        }
  }else{
    var labelType = 'key';
  }
  
  //Set up donut
  if( typeof input.donut != 'undefined' ) {
    var donut = Boolean(input.donut);
  }else{
    var donut = false;
  }
  
  if( typeof input.donutRatio != 'undefined' ){
    var donutRatio = input.donutRatio;
  }else{
    var donutRatio = 0.35;
  }

  var $el = $(el);
    
  // The first time we render a value for a particular element, we
  // need to initialize the nvd3 line chart and d3 selection. We'll
  // store these on $el as a data value called "state".
  if (!$el.data("state")) {
    var chart =nv.models.pieChart()
      .margin(mar)
      .x(function(d) { return d.label })
      .y(function(d) { return d.value })
      .tooltips(showTooltips)
      .showLabels(showLabels)
      .labelThreshold(labelTheshold)
      .labelType(labelType)
      .donut(donut)
      .donutRatio(donutRatio);
    
    
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
      .labelThreshold(labelTheshold)
      .donutRatio(donutRatio);
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
Shiny.outputBindings.register(binding, "shinyjsexamples.nvd3-piechart");

})();
