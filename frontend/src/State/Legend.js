import React from 'react';
import * as d3 from "d3";

const Legend = (props) => {
    const {colors} = props.colors
    const {lower_thresholds} = props.lowerRanges
    
    var color_scale = d3.scaleQuantile().domain(lower_thresholds).range(colors)

    var legendKeys = []
    var previousValue = 0
    for (i = 0; i < lower_thresholds.length; i++) {
        if (previousValue == lower_thresholds[i]) {
            legendKeys.append(`${lower_thresholds[i]}%`)
        } else {
            legendKeys.append(`${previousValue}%-${lower_thresholds[i]}%`)
            previousValue = lower_thresholds[i]
        }
    }

    
    svg = d3.select(ref.current);
    svg.selectAll('rect')
    .data(legendKeys)
    .enter()
    .append("rect")
        .attr("x", 100)
        .attr("y", function(d,i){ return 100 + i*(size+5)}) // 100 is where the first dot appears. 25 is the distance between dots
        .attr("width", 20)
        .attr("height", 20)
        .style("fill", function(d){ return color_scale(d)})

        SVG.selectAll("mylabels")

    svg.selectAll('text').data(keys)
    .enter()
    .append("text")
        .attr("x", 100 + size*1.2)
        .attr("y", function(d,i){ return 100 + i*(size+5) + (size/2)}) // 100 is where the first dot appears. 25 is the distance between dots
        .style("fill", function(d){ return color(d)})
        .text(function(d){ return d})
        .attr("text-anchor", "left")
        .style("alignment-baseline", "middle")

    return (
        <div className="legend">
            <svg ref={ref}>
            </svg>
        </div>
    )
}

export default Legend;