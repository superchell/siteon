import React, {Component, Fragment} from 'react'
import Nav from './Nav';

export default class Home extends Component{
    state = {
        data: this.props.data
    }

    _getData = () => {
        const link = this.props.location;
        return(
            fetch(`${link.pathname}?format=json`)
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    this.setState({
                        data: data
                    })
                })
        )
    }

    componentDidMount(){
        if (this.props.client){
            this._getData();
        }
    }


    render(){
        const {description,title} = this.state.data
        return(
            <Fragment>
                <h2>Home</h2>
                <h3>{title}</h3>
                <p dangerouslySetInnerHTML={{__html: description}} />
                <Nav />
            </Fragment>
        )
    }
}