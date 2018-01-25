import "./css/index.css";
import "./css/googlefonts.css";
import "bootstrap/dist/css/bootstrap.css";
import "./css/font-awesome.css.scss";
import "./css/animate.css";
import "ionicons/dist/scss/ionicons";
import 'owl.carousel/dist/assets/owl.carousel.css';
import "./css/style.css.scss";
import "./css/responsive.css";
import "./css/intlTelInput.css.scss";

("use strict");

/* importing plugins */
import WOW from 'wow.js';
import 'bootstrap';
require("imports-loader?$=jquery!jquery.nicescroll/dist/jquery.nicescroll.js");
require("imports-loader?$=jquery!owl.carousel/dist/owl.carousel.js");

/*************************
 owl-carousel
 *************************/
$(".owl-carousel").each(function () {
    var $this = $(this),
        $items = ($this.data('items')) ? $this.data('items') : 1,
        $loop = ($this.data('loop')) ? $this.data('loop') : true,
        $navdots = ($this.data('nav-dots')) ? $this.data('nav-dots') : false,
        $navarrow = ($this.data('nav-arrow')) ? $this.data('nav-arrow') : false,
        $autoplay = ($this.attr('data-autoplay')) ? $this.data('autoplay') : true,
        $space = ($this.attr('data-space')) ? $this.data('space') : 15;
    $(this).owlCarousel({
        loop: $loop,
        items: $items,
        responsive: {
            0: {
                items: $this.data('xx-items') ? $this.data('xx-items') : 1
            },
            600: {
                items: $this.data('xs-items') ? $this.data('xs-items') : 1
            },
            767: {
                items: $this.data('sm-items') ? $this.data('sm-items') : 2
            },
            992: {
                items: $this.data('md-items') ? $this.data('md-items') : 2
            },
            1190: {
                items: $this.data('lg-items') ? $this.data('lg-items') : 3
            },
            1200: {
                items: $items
            }
        },
        dots: $navdots,
        margin: $space,
        nav: $navarrow,
        navText: ["<i class='fa fa-angle-left fa-2x'></i>", "<i class='fa fa-angle-right fa-2x'></i>"],
        autoplay: $autoplay,
        autoplayHoverPause: true
    });

});


/*************************
 page loader
 *************************/
function preloader() {
  $("#load").fadeOut();
  $("#loading")
    .delay()
    .fadeOut();
}

/*************************
 Wow Animation
 *************************/
function wowanimation() {
    var wow = new WOW({
        boxClass: 'wow',
        animateClass: 'animated',
        offset: 0,
        mobile: false,
        live: true
    });
    wow.init();
}

/*************************
 Header
 *************************/
function header() {
    $(window).on('scroll', function () {
        if ($(this).scrollTop() > 100) {
            $('.menu-top').addClass('menu-sticky');
        } else {
            $('.menu-top').removeClass('menu-sticky');
        }
    });
}

/*************************
 Cursor animation
 *************************/
if (window.innerWidth >= 1048) {
    $(document).ready(function() {

        var nice = $("html").niceScroll({
            scrollspeed :  80
        });

    });
}

var scroll = $(window).scrollTop();
$('.paralax-block').css({ transform: 'translateY('+ -scroll +'px)'});

$(window).scroll(function () {
    var scroll = $(window).scrollTop() / 2;
    $('.paralax-block').css({ transform: 'translateY('+ -scroll +'px)'});
});

/** init scripts **/
$(document).ready(function() {
  preloader();
  header();
});

$(window).on('load', function () {
    wowanimation();
});

function mainMenuModifier() {
    var items = $('#main_menu').find('.menu-item > a');
    items.each(function(){
        if ($(this).attr('href').match('#') !== null)
            $(this).attr('href', "/" + $(this).attr('href'))
    });
}