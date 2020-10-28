import React from 'react'
import styled from 'styled-components'


const Box = styled.div`
    background: #fff;
    height: ${props => props.border_length}vh;
    width: ${props => props.border_length}vh;
    border: 2px solid ${props => props.border_color};
`

const County = (props) => {
    const {name, dem, gop} = props.attributes

    let border_color
    let difference = dem - gop;
    if (difference < 0) {
        border_color = "darkred"
    } else if (difference > 0) {
        border_color = "powderblue"
    } else {
        border_color = "white"
    }

    let border_length = Math.sqrt(Math.abs(difference))/5


    return (
        <Box border_length={border_length} border_color={border_color}>
            {name}
        </Box>
    )
}

export default County;