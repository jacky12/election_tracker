import React, { useState, useEffect } from "react";
import axios from "axios"
import styled from 'styled-components'
import County from './County'
import Legend from "./Legend";
import Treemap from "./Treemap";
import dem_legend from './../../../assets/images/dem_legend.png';
import gop_legend from './../../../assets/images/gop_legend.png';
// import { Link } from "react-router-dom";

const Wrapper = styled.div`
    margin-left: auto;
    margin-right: auto;
    display: grid;
`
const Title = styled.div`
    display: flex;
`

const SubHeader = styled.div`
    display: flex;
    padding-bottom: 50px;
`

const Row = styled.div`
    display: flex;
    justify-content: center;
`
const Column = styled.div`
    background: #fff;
    width: 600px;
    max-width: 50%;
    float: left;
    display: flex;
`

const CountiesWrapper = styled.div`
    // display: inline-block;
    align-items: flex-end;
    align-self: flex-end;
    display: flex;
    flex-wrap: wrap;
`
// TODO: deal with then they are equal
function isDem(county) {
    let dem_votes = county.attributes.dem
    let gop_votes = county.attributes.gop
    return (dem_votes > gop_votes)
}

function categorize_counties(counties, callback){
    return counties.reduce(function(result, element, i) {
      callback(element, i, counties) 
        ? result[0].push(element) 
        : result[1].push(element);
  
          return result;
        }, [[],[]]
      );
   };

function sort_biggest_to_smallest_diff(counties){
    counties.sort((a, b) => (a.attributes.difference > b.attributes.difference) ? 1 : -1)
}

function sum_counties_margin(accumulator, county) {
    return accumulator + county.value
}
  

const State = (props) => {
    const [state, setState] = useState({})
    const [county, setCounty] = useState({})
    const [loaded, setLoaded] = useState(false)

    useEffect(() => {
        const slug = props.match.params.slug
        const url = `/api/v1/states/${slug}`

        axios.get(url)
        .then( response => {
            setState(response.data)
            setLoaded(true)
        })
        // .then( response => console.log(response))
        .catch( response => console.log(response) )
    }, [])

    var gop_data = {}
    var dem_data = {}
    var dem_height_multiplier
    var gop_height_multiplier

    if (loaded && state.included) {
        const counties = state.included
        const [dem_counties, gop_counties] = categorize_counties(counties, isDem)

        var dem_county_items = dem_counties.map( (item) => {
            return (
                {
                    name: item.attributes.name,
                    value: item.attributes.difference,
                    percentReporting: item.attributes.percentage_reporting
                }
            )
        })

        var dem_margin = dem_county_items.reduce(sum_counties_margin, 0)
        dem_data = {
            name: "Democrat Election Results",
            children: [{
                name: "Democrat",
                children: dem_county_items
            }]
        }

        var gop_county_items = gop_counties.map( (item) => {
            return (
                {
                    name: item.attributes.name,
                    value: item.attributes.difference,
                    percentReporting: item.attributes.percentage_reporting
                }
            )
        })

        var gop_margin = gop_county_items.reduce(sum_counties_margin, 0)
        gop_data = {
            name: "Republican Election Results",
            children: [{
                name: "Republican",
                children: gop_county_items
            }]
        }

        if (dem_margin > gop_margin) {
            dem_height_multiplier = 1
            gop_height_multiplier = gop_margin/dem_margin
        } else {
            dem_height_multiplier = dem_margin/gop_margin
            gop_height_multiplier = 1
        }
    }

    return (
        <Wrapper>
            <Row>
                {
                    loaded &&
                        <>
                            <h2>{state.data.attributes.name}</h2>
                        </>
                }
            </Row>
            <Row>
                {
                    loaded &&
                    <>
                        <Column>
                            <CountiesWrapper>
                                <Treemap
                                    width={600}
                                    height={600*dem_height_multiplier}
                                    data={dem_data}
                                />
                            </CountiesWrapper>
                        </Column>
                        <Column>
                            <CountiesWrapper>
                                <Treemap
                                    width={600}
                                    height={600*gop_height_multiplier}
                                    data={gop_data}
                                />
                            </CountiesWrapper>
                        </Column>
                    </>
                }
            </Row>
            <Row>
                {
                    loaded &&
                    <>
                        <Column>
                            <img src={dem_legend} width="600" height="75" />
                        </Column>
                        <Column>
                            <img src={gop_legend} width="600" height="75" />
                        </Column>
                    </>
                }
            </Row>
        </Wrapper>
    )
}

export default State;
