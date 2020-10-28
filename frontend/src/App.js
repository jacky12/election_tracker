import React from "react";
import {Route, Switch} from 'react-router-dom'
import States from './States/States'
import State from './State/State'

const App = () => {
    return (
        <Switch>
            <Route exact path="/" component={States}/>
            <Route exact path="/states/:slug" component={State}/>
        </Switch>
    )
}

export default App