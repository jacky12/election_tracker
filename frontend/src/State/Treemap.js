import * as d3 from 'd3';
import React, { useRef, useEffect } from 'react';

function Treemap({ width, height, data }){
    const ref = useRef();

    useEffect(() => {
        const svg = d3.select(ref.current)
            .attr("width", width)
            .attr("height", height)
            .style("border", "1px solid black")
    }, []);

    useEffect(() => {
        draw();
    }, [data]);

    const draw = () => {
        const svg = d3.select(ref.current);

        // Give the data to this cluster layout:
        var root = d3.hierarchy(data)
            .sum(function(d){ return d.value})
            .sort((a, b) => {
                return a.value - b.value;
            });

        // initialize treemap
        d3.treemap()
            .size([width, height])
            (root);
        
        const color = function(party, percentageReporting) {
            if (party == "Democrat") {
                if (percentageReporting <= 0.25) {
                    return "#c8e7fc";
                } else if (percentageReporting <= 0.5) {
                    return "#92b9dd";
                } else if (percentageReporting <= 0.75) {
                    return "#568abe"
                } else if (percentageReporting < 1) {
                    return "#257cba"
                } else {
                    return "#00619f"
                }
            } else if (party == "Republican") {
                if (percentageReporting <= 0.25) {
                    return "#f9c9ca";
                } else if (percentageReporting <= 0.5) {
                    return "#e4918e";
                } else if (percentageReporting <= 0.75) {
                    return "#c65654"
                } else if (percentageReporting < 1) {
                    return "#c6172a"
                } else {
                    return "#a41827"
                }
            }
        }

        const opacity = d3.scaleLinear()
            .domain([10, 30])
            .range([.5,1]);


        // Select the nodes
        var nodes = svg
                    .selectAll("rect")
                    .data(root.leaves())

        // animate new additions
        nodes
            .transition().duration(300)
                .attr('x', function (d) { return d.x0; })
                .attr('y', function (d) { return d.y0; })
                .attr('width', function (d) { return d.x1 - d.x0; })
                .attr('height', function (d) { return d.y1 - d.y0; })
                .style("opacity", function(d){ return opacity(d.data.value)})
                .style("fill", function(d){ return color(d.parent.data.name, d.data.percentReporting)} )
        
        // draw rectangles
        nodes.enter()
            .append("rect")
            .attr('x', function (d) { return d.x0; })
            .attr('y', function (d) { return d.y0; })
            .attr('width', function (d) { return d.x1 - d.x0; })
            .attr('height', function (d) { return d.y1 - d.y0; })
            .style("stroke", "black")
            .style("fill", function(d){ return color(d.parent.data.name, d.data.percentReporting)} )
            .style("opacity", function(d){ return opacity(d.data.value)})

        nodes.exit().remove()

        // select node titles
        var nodeText = svg
            .selectAll("text")
            .data(root.leaves())

        // animate new additions
        nodeText
            .transition().duration(300)
                .attr("x", function(d){ return d.x0+5})
                .attr("y", function(d){ return d.y0+20})
                .text(function(d){ return d.data.name.replace(' County','') })
        
        // add the text
        nodeText.enter()
            .append("text")
            .attr("x", function(d){ return d.x0+5})    // +10 to adjust position (more right)
            .attr("y", function(d){ return d.y0+20})    // +20 to adjust position (lower)
            .text(function(d){ return d.data.name.replace(' County','') })
            .attr("font-size", "15px")
            .attr("fill", "black")
            .style('opacity', function(d){
                var bbox = this.getBBox();
                if ( d.x1 < bbox.x + bbox.width || d.y1 < bbox.y + bbox.height ) {
                  return 0;
                }
                return 1;
              });
        
        // select node titles
        var nodeVals = svg
            .selectAll("vals")
            .data(root.leaves())  

        nodeVals
            .transition().duration(300)
                .attr("x", function(d){ return d.x0+5})
                .attr("y", function(d){ return d.y0+35})
                .text(function(d){ return d.data.value })

        // add the values
        nodeVals.enter()
            .append("text")
            .attr("x", function(d){ return d.x0+5})    // +10 to adjust position (more right)
            .attr("y", function(d){ return d.y0+35})    // +20 to adjust position (lower)
            .text(function(d){ return d.data.value })
            .attr("font-size", "11px")
            .attr("fill", "black")
            .style('opacity', function(d){
                var bbox = this.getBBox();
                if ( d.x1 < bbox.x + bbox.width || d.y1 < bbox.y + bbox.height ) {
                  return 0;
                }
                return 1;
              });
    }


    return (
        <div className="chart">
            <svg ref={ref}>
            </svg>
        </div>
        
    )

}

export default Treemap;