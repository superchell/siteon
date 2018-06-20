import React, {Component} from 'react'
import { Link } from 'react-router-dom'

export default class Nav extends Component{
    render(){
        return(
            <div className="nav-link">
                <Link to='/rekt-test'>Home</Link> | <Link to='/rekt-test-stranitsa-2'>Portfolio</Link>
            </div>
        )
    }
}