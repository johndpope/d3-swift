'use strict';
//import d3Scale from 'd3-scale';
//import d3Shape from 'd3-shape';
//import d3Array from 'd3-array';

var getPath = function(data, dim) {
  const [w, h] = dim; 
  const x = d3.scaleLinear()
    .domain([0, data.length])
    .range([0, w]);
  
  const y = d3.scaleLinear()
    .domain([0, d3.max(data)])
    .range([0, h]);
    
  const line = d3.line()
    .x((d, i) =>  x(i))
    .y((d, i) => y(d))
    .curve(d3.curveBasis);
  
  return line(data);
}

var document = ""

var barChart = function(data, dim) {
    const [w, h] = dim;
    const barPadding = 1;
    
    var outputSVG = document.createElementNS(d3.namespaces.svg, 'svg')
    var svg = d3.select(outputSVG)
                .attr("width", w)
                .attr("height", h);
    
    svg.selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("x", function(d, i) { return i * (w / data.length); })
        .attr("y", function(d) { return h - (d * 4); })
        .attr("width", w / data.length - barPadding)
        .attr("height", function(d) { return d * 4; })
        .attr("fill", "teal");
    
    svg.selectAll("text")
        .data(data)
        .enter()
        .append("text")
        .text(function(d) { return d; })
        .attr("text-anchor", "middle")
        .attr("x", function(d, i) {
              return i * (w / data.length) + (w / data.length - barPadding) / 2;
          })
        .attr("y", function(d) { return h - (d * 4) + 14; })
        .attr("font-family", "sans-serif")
        .attr("font-size", "11px")
        .attr("fill", "white");
    
}
