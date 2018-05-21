import React, {Component} from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import ReactTransitionGroup from 'react-addons-transition-group';

// images import
import logo_SiteOn_white from "./images/logo_SiteOn_white.svg";
import logo_menu from "./images/logo-menu.png";

class Header extends Component {
    constructor(){
        super();
        this.state = {
            menuOpen: false
        }
    }

    openMenu = () =>{
        this.setState({
            menuOpen: !this.state.menuOpen
        });
    }

    render() {
        return (
            <React.Fragment>
                <div className="header">
                    <div className="container">
                        <div className="header-wrapper">
                            <div className="logo"><img src={logo_SiteOn_white} width="125" alt="siteon-logo"
                                                       className="image" alt=""/></div>
                            <div className="header-right">
                                <SelectPhone />
                                <a href="javascript:;" onClick={this.openMenu} data-w-id="41cfee9f-d442-c219-df4f-06a9e7f72a26" className="menu-link">Меню<span
                                    className="menu-gamberger"><br/></span></a></div>
                        </div>
                    </div>
                </div>
                <MainMenu open={this.state.menuOpen} closeMenu={this.openMenu}  />
            </React.Fragment>
        );
    }
}

class SelectPhone extends Component {
    constructor(){
        super();
        this.state = {
            open: false
        }
    }

    dropDown = () =>{
        if (this.state.open){
            return(
                    <div className="select-phones-hide">
                        <a href="tel:+380664191125" onClick={this.state.open ?  this.callFunc : this.openClose} className="select-phones-open">
                            <span className="select-phones-ico i-vodafon"></span>
                            +38(066) 419 11 25
                        </a>
                    </div>
                )
        }else {
            return null;
        }
    }

    openClose = (e) =>{
        this.setState({
           open: !this.state.open
        });

        e.preventDefault();
    }

    callFunc = () =>{
        this.setState({
            open: !this.state.open
        });
    }

    render(){
        return(
            <div className="select-phones">
                <a href="tel:+380986371893" onClick={this.state.open ? this.callFunc : this.openClose}  className="select-phones-open select-open-trigger">
                    <span className="select-phones-ico"></span>
                    +38(098) 637 18 93
                    <span  className={this.state.open ? "text-span open" : "text-span"}></span>
                </a>
                <ReactCSSTransitionGroup
                    transitionName="example"
                    transitionEnterTimeout={500}
                    transitionLeaveTimeout={300}>

                    {this.dropDown()}
                </ReactCSSTransitionGroup>

            </div>
        )
    }
}

class MainMenu extends Component {
    constructor(props){
        super(props);
        this.state = {
            open: props.open
        }
    }

    componentWillReceiveProps(nextProps){
        this.setState({
            open: nextProps.open
        });
    }

    renderMenu = () => {
        if (this.state.open){
            return(
                <MenuInner props={this.props} closeMenu={this.props.closeMenu} />
            )
        }else {
            return null
        }
    }


    render(){
        return(
            <ReactTransitionGroup>
                {  this.renderMenu() }
            </ReactTransitionGroup>
        )
    }
}

class MenuInner extends Component{

    componentWillEnter (callback) {
        const mainMenu = this.container;
        const menuContainer = $(mainMenu).find('.menu-container');
        const tl = new TimelineMax();

        TweenMax.set(menuContainer, {x: '100%'});

        tl.add( TweenMax.fromTo(mainMenu, 0.3, {opacity: 0}, {opacity: 1}) );
        tl.add( TweenMax.to(menuContainer, 0.3, {x: '0%', onComplete: callback}), '-=0.2');
    }

    componentWillLeave (callback) {
        const el = this.container;
        TweenMax.fromTo(el, 0.2, {opacity: 1}, {opacity: 0, onComplete: callback});
    }


    linkAction = () =>{
        this.props.closeMenu()
    }

    render(){
        return(
            <div className="main-menu" ref={c => this.container = c}>
                <div  className="menu-container">
                    <div className="menu-logo"><img src={logo_menu}/></div>
                    <div className="menu-list">
                        <ul className="menu-list-items">
                            <li><a href="#choice" onClick={this.linkAction} className="menu-list-items__a active"><span className="menu-link-inner active">Почему работает?</span></a></li>
                            <li><a href="#hards" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Ваши потери сейчас!</span></a></li>
                            <li><a href="#gains" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Выгоды</span></a></li>
                            <li><a href="#trump" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Особенности</span></a></li>
                            <li><a href="#bonus" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Бонус</span></a></li>
                            <li><a href="#quality" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Ваш результат</span></a></li>
                            <li><a href="#price" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Цена</span></a></li>
                            <li><a href="#reviews" onClick={this.linkAction} className="menu-list-items__a"><span className="menu-link-inner">Отзывы</span></a></li>
                        </ul>
                    </div>
                    <div className="social-list">
                        <a href="#" className="social-link"></a>
                        <a href="#" className="social-link"></a>
                        <a href="#" className="social-link"></a>
                    </div>
                    <a href="javascript:;" onClick={this.props.closeMenu} className="close-menu"></a>
                </div>
            </div>
        )
    }
}

export default Header;
