import React, { useState, useEffect, Fragment } from "react";
import axios from "axios"
import State from "./State"
// import { Link } from "react-router-dom";

const States = () => {
    const [states, setStates] = useState([])

    useEffect(() => {
        // Get all states from API
        axios.get('/api/v1/states.json')
        .then( response => {
            setStates(response.data.data)
        } )
        .catch( response => console.log(response) )
        // Update states in our state
    }, [states])
    // TODO: change this to trigger when numbers are updated

    const states_rows = states.map( item => {
        return (
            <State 
                key={item.attributes.name}
                attributes={item.attributes}
            />
        )
    })

    return (
        <div className="home">
            <div className="header">
                <h1>ElectionTracker</h1>
                <div className="subheader">A new way to view elections.</div>
            </div>
            <table>
                <tbody>
                    <tr>
                        <th>Name</th>
                        <th>Democrat</th>
                        <th>Republican</th>
                        <th></th>
                    </tr>
                    {states_rows}
                </tbody>
            </table>
        </div>
    )
}

export default States;