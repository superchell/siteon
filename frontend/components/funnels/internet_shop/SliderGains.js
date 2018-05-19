import React, { Component } from 'react';


class SliderGains extends Component {

    weel = () =>{
        console.log('asd');
    }

    render() {
        return (
            <div onWheel={this.weel} style={{height:"800px"}}>asd</div>
        );
    }
}

export default SliderGains;