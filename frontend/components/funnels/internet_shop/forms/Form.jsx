import React, {Component} from 'react';

class Form extends Component {
    constructor(props) {
        super(props);
        this.state = {value: ''};

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({value: event.target.value});
    }

    handleSubmit(event) {
        fetch('/plugins/cama_contact_form/save_form', {
            method: 'POST',
            headers: new Headers(),
            body: JSON.stringify({
                id: 57,
                authenticity_token: $('#edit_plugins_cama_contact_form_cama_contact_form_57 input[name="authenticity_token"]').val() ,
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