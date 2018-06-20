import React from 'react'
import {BrowserRouter, StaticRouter, Route, Switch} from 'react-router-dom'

import Home from './Home';
import Portfolio from './Portfolio';


class Router extends React.Component {
    renderRouter = () => {
        if (typeof window !== 'undefined') {
            return (
                <BrowserRouter>
                    {this.props.children}
                </BrowserRouter>
            )
        } else {
            return (
                <StaticRouter location={this.props.path} context={{}}>
                    {this.props.children}
                </StaticRouter>
            )
        }
    }

    render() {
        return (this.renderRouter())
    }
}

const App = props => {
    const {data,client} = props;
    return (
        <Router path={props.path}>
            <Switch>
                <Route path="/rekt-test" render={props => ( <Home {...props} data={data} client={client}/> )}/>)} />
                <Route path="/rekt-test-stranitsa-2" render={props => ( <Portfolio {...props} data={data} client={client} /> )}/>
            </Switch>
        </Router>
    )
}


export default App