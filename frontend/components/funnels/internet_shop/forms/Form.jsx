import React, {Component} from 'react';

class Form extends Component {
    constructor(props) {
        super(props);
        this.state = {
            value: '',
            token: ''
        };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
        this.fromData();
    }

    handleChange(event) {
        this.setState({value: event.target.value});
    }

    fromData = () => {
        fetch(`${window.location.href}?format=json`)
            .then(function(response) {
                return response.json();
            })
            .then((data) => {
                this.setState({
                    token: data.form_token
                })
            })
    }

    handleSubmit(event) {
        fetch('/plugins/cama_contact_form/save_form', {
            method: 'POST',
            headers: new Headers(),
            body: JSON.stringify({
                id: 1,
                authenticity_token: this.state.token ,
                'fields[c2]': 'Gena',
                'fields[c6]': '+380660297109',
                'fields[c5]': "acidcrash2005@gmail.com"
            })
        }).then((res) => res.json())
            .then((data) => console.log(data))
            .catch((err) => console.log(err))

        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    Name:
                    <input type="text" value={this.state.value} onChange={this.handleChange}/>
                </label>
                <input type="submit" value="Submit"/>
            </form>
        );
    }
}

export default Form;