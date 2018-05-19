import React, { Component } from 'react';
import Header from "./Header";
import MainBlock from "./blocks/MainBlock";

class App extends Component {
  render() {
    return (
      <div className="App">
        <Header/>
        <MainBlock />
      </div>
    );
  }
}

export default App;
