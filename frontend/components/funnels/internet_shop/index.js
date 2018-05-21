import React from 'react';
import ReactDOM from 'react-dom';
import {TweenMax, TimelineMax} from 'gsap';
import ScrollMagic from "scrollmagic";
//import 'scrollmagic/scrollmagic/uncompressed/plugins/debug.addIndicators';
import Swiper from 'swiper';
import "swiper/dist/css/swiper.css";

import App from './App';
import "./forms";

import SliderGains from './SliderGains';
import "./scss/google_fonts.scss";
import "./css/normalize.css";
import "./css/webflow.css";
import "./css/lending-shop.webflow.scss";
import "./scss/style.scss";


ReactDOM.render(<App />, document.getElementById('landingShop'));
//ReactDOM.render(<SliderGains />, document.getElementById('slider_gains'));

var controller = new ScrollMagic.Controller();

$(function () { // wait for document ready

    /*
    * SLIDER 1
    * */
    // build scene
    let countEl = $('.gains .swiper-slide').length;
    let duratrion = countEl * $('.gains .swiper-slide').outerHeight(true);

    let offset1 = 350;


    var scene = new ScrollMagic.Scene({triggerElement: "#trigger1", duration: duratrion * 1.5, offset: offset1 }) //- 217
        .setPin("#pin1")
        //.addIndicators({name: "1 (duration: 300)"}) // add indicators (requires plugin)
        .addTo(controller);


    scene.on("progress", function (event) {
        swiper.slideTo(Math.floor( event.progress * 10 / 2));
    });

    var swiper = new Swiper('.gains .swiper-container', {
        pagination: {
            el: '.gains .swiper-pagination',
        },
        simulateTouch:false,
        allowTouchMove: false
    });



    /*
    * SLIDER 2
    * */
    // build scene
    let countEl2 = $('.swiper-slide').length;
    let duratrion2 = countEl * $('.swiper-slide').outerHeight(true);

    var scene2 = new ScrollMagic.Scene({triggerElement: "#trigger2", duration: duratrion2 * 2, offset: offset1})
        .setPin("#pin2")
        //.addIndicators({name: "1 (duration: 300)"}) // add indicators (requires plugin)
        .addTo(controller);


    scene2.on("progress", function (event) {
        swiper2.slideTo(Math.floor( event.progress * 10 / 2) );

    });

    var swiper2 = new Swiper('.slider2 .swiper-container', {
        pagination: {
            el: '.slider2 .swiper-pagination',
        },
        simulateTouch:false,
        allowTouchMove: false,
        slidesPerView: 2,
        slidesPerGroup: 2,
        breakpoints: {
            768: {
                slidesPerView: 1,
                slidesPerGroup: 1,
            }
        }
    });
});
