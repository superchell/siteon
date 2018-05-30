import React from 'react';
import ReactDOM from 'react-dom';
import {TweenMax, TimelineMax} from 'gsap';
import ScrollMagic from "scrollmagic";
//import 'scrollmagic/scrollmagic/uncompressed/plugins/debug.addIndicators';
import Swiper from 'swiper';
import "swiper/dist/css/swiper.css";

import App from './App';

import "./scss/google_fonts.scss";
import "./css/normalize.css";
import "./css/webflow.css";
import "./css/lending-shop.webflow.scss";
import "./scss/style.scss";
import "jquery-mask-plugin";
import "./form";



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
        spaceBetween: 60,
        simulateTouch:false,
        allowTouchMove: false
    });



    /*
    * SLIDER 2
    * */
    // build scene
    let duratrion2 = countEl * $('.slider-t1 .swiper-slide').outerHeight(true);

    var scene2 = new ScrollMagic.Scene({triggerElement: "#trigger2", duration: duratrion2 * 1.5, offset: offset1 - 60})
        .setPin("#pin2")
        //.addIndicators({name: "1 (duration: 300)"}) // add indicators (requires plugin)
        .addTo(controller);


    scene2.on("progress", function (event) {
        swiper2.slideTo(Math.floor( event.progress * 10 / 1.5) );

    });

    var swiper2 = new Swiper('.slider-t1 .swiper-container', {
        pagination: {
            el: '.slider-t1 .swiper-pagination',
        },
        simulateTouch:false,
        allowTouchMove: false,
        slidesPerView: 2,
        slidesPerGroup: 2,
        spaceBetween: 60,
        breakpoints: {
            1024: {
                slidesPerView: 1,
                slidesPerGroup: 1,
            }
        }
    });


    /*
    * SLIDER 3
    * */
    // build scene
    let duratrion3 = countEl * $('.slider-t2 .swiper-slide').outerHeight(true);

    var scene3 = new ScrollMagic.Scene({triggerElement: "#trigger3", duration: duratrion3 * 1.5, offset: offset1 - 60})
        .setPin("#pin3")
        .addTo(controller);


    scene3.on("progress", function (event) {
        swiper3.slideTo(Math.floor( event.progress * 10 / 1.5) );
    });

    var swiper3 = new Swiper('.slider-t2 .swiper-container', {
        pagination: {
            el: '.slider-t2 .swiper-pagination',
        },
        simulateTouch:false,
        spaceBetween: 60,
        allowTouchMove: false
    });

    swiper3.on('slideChange', function () {
        if(swiper3.realIndex == 3){
            document.getElementById('example').play();
        }else{
            document.getElementById('example').pause();
        }
    });


});
