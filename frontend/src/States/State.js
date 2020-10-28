import React from 'react'
import { BrowserRouter as Router, Link } from 'react-router-dom'

const State = (props) => {
    return (
        <tr>
            <td>{props.attributes.name}</td>
            <td>{props.attributes.total_dem_votes}</td>
            <td>{props.attributes.total_gop_votes}</td>
            <td><Link to={`/states/${props.attributes.slug}`}>View State</Link></td>
        </tr>
    )
}

export default State;