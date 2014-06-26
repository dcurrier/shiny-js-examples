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
      
      chart.dispatch = d3.dispatch('tooltipShow', 'tooltipHide', 'stateChange', 'changeState', 'renderEnd');
      
    chart.xAxis     //Chart x-axis settings
      .axisLabel(xlabel)
      .tickFormat(d3.format(',r'));
      
    // Apply xDomain if applicable
    if (typeof xDomain != 'undefined') {
      chart.xDomain(xDomain);
    }
 
    chart.yAxis     //Chart y-axis settings
      .axisLabel(ylabel)
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
      .yAxis.axisLabel(ylabel);
    state.chart
      .xDomain(xDomain)
      .xAxis.axisLabel(xlabel);
    state.selection
      .datum(input.data)
      .transition(500)
      .call(state.chart);
    
    // Setup a function to adjust the CSS of lines to be points
    var mkpoints = function(types){
       var elm = $el.find('g.nv-legend').children().children();
       var series = 0;

       // Iterate over length of elm to set CSS according to the correct path
       for(i=0; i<elm.length; i++){
         if($(elm[i]).attr('class').split( " ").indexOf('disabled') < 0){
           var points = 'g.nv-scatter g.nv-series-'+series+' circle.nv-point';
           var lines = 'g.nv-series-'+series+' path.nv-line';
           
           switch(types[i]){
                case "p":            
                    $el.find($(points)).css('fill-opacity', "1").css('stroke-opacity', "1");
                    $el.find($(lines)).parent().css('stroke-opacity', "0").css('stroke', '');
                    break;
                case "l":
                    $el.find($(points)).css('fill-opacity', "0").css('stroke-opacity', "0");
                    $el.find($(lines)).parent().css('stroke-opacity', "1");
                    break;
                case "b":
                    $el.find($(points)).css('fill-opacity', "1").css('stroke-opacity', "1");
                    $el.find($(lines)).parent().css('stroke-opacity', "1");
                    break;
                case "n":
                    $el.find($(points)).css('fill-opacity', "0").css('stroke-opacity', "0");
                    $el.find($(lines)).parent().css('stroke-opacity', "0").css('stroke', '');
                    break;
           } // End Switch
           
           // Advance series counter
           series++;
           
         } // End If
                  
       } // End For
     } // End Function
     
    
    
    // chart was not updating on windowResize until I put this here
    // mkpoints needs to be called on updates to reset the css properties
    nv.utils.windowResize(function(){
                            state.chart.update();
                            mkpoints(input.type);                 
      });
    
    // Refresh the CSS for the series when the legend is toggled
    state.chart.legend.dispatch.on('legendClick', function(e){
      setTimeout(function(){ mkpoints(input.type) }, 10);
    });
    
    
    $(document).ready(mkpoints(input.type)); // Schedule CSS update after document loads
    
    return state.chart;
  });
  
 
  
  
  //state.chart.dispatch.on('beforeUpdate', function(e){console.debug(e)});
  //state.chart.dispatch.on('beforeUpdate', console.debug('beforeUpdate'));
  //state.chart.dispatch.on('changeState.directive', console.debug('changeState'));
  //state.chart.dispatch.on('tooltipShow.directive', console.debug('tooltipShow'));
  //state.chart.dispatch.on('tooltipHide.directive', console.debug('tooltipHide'));
  //state.chart.dispatch.on('stateChange.directive', console.debug('stateChange'));
  //state.chart.dispatch.on('stateChange.legend.directive', console.debug('stateChange.legend'));
  //state.chart.dispatch.on('legendClick.directive', console.debug('legendClick'));
  
};



// Tell Shiny about our new output binding
Shiny.outputBindings.register(binding, "shinyjsexamples.nvd3-linechart");

})();
