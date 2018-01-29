import "./css/index.css";
import "./css/googlefonts.css";
import "bootstrap/dist/css/bootstrap.min.css";
import "font-awesome/scss/font-awesome.scss";
import "animate.css/animate.min.css";
import "ionicons/dist/scss/ionicons.scss";
import 'owl.carousel/dist/assets/owl.carousel.css';
import "./css/style.css.scss";
import "./css/responsive.css";
import "intl-tel-input/build/css/intlTelInput.css";

("use strict");

/* importing plugins */

import WOW from 'wow.js';
import skrollr from 'skrollr';

import 'bootstrap';

require("imports-loader?$=jquery!jquery.nicescroll/dist/jquery.nicescroll.js");
require("imports-loader?$=jquery!owl.carousel/dist/owl.carousel.js");
require("imports-loader?$=jquery!intl-tel-input/build/js/intlTelInput.js");


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
 Back to top
 *************************/
function backtotop() {
    $('#back-to-top').fadeOut();
    $(window).scroll(function () {
        if ($(this).scrollTop() > 250) {
            $('#back-to-top').fadeIn(1500);
        } else {
            $('#back-to-top').fadeOut(500);
        }
    });
    // scroll body to 0px on click
    $('#top').on('click', function () {
        $('top').tooltip('hide');
        $('body,html').animate({
            scrollTop: 0
        }, 800);
        return false;
    });
}

$(function(){
    /*************************
     Phone Validation
     *************************/

    var telInput = $("input[type='tel']"),
        errorMsg = $(".error-msg"),
        validMsg = $(".valid-msg");

    telInput.intlTelInput({
        preferredCountries: ["ua", "pl", "us"],
        utilsScript: theme_utils_path
    });

    var reset = function() {
        telInput.removeClass("error");
        errorMsg.addClass("hide");
        validMsg.addClass("hide");
    };

    telInput.blur(function() {
        reset();
        if ($.trim($(this).val())) {
            if ($(this).intlTelInput("isValidNumber")) {
                validMsg.removeClass("hide");
            } else {
                $(this).addClass("error");
                errorMsg.removeClass("hide");
            }
        }
    });

    // on keyup / change flag: reset
    telInput.on("keyup change", reset);

    $('.validate-form').submit(function (e) {
        var form = $(this);
        telInput = form.find("input[type='tel']");

        if ($.trim(telInput.val())) {
            if (telInput.intlTelInput("isValidNumber")) {
                validMsg.removeClass("hide");
                telInput.val(telInput.intlTelInput("getNumber", intlTelInputUtils.numberFormat.E164));
            } else {
                telInput.addClass("error");
                errorMsg.removeClass("hide");
                return false;
            }
        }

        $.post(form.attr('action'), form.serialize(), function(response){
            if (response.error != undefined) {
                displayError(form, response.error);
                return false
            }

            if (response.notice != undefined){
                displaySuccess(form, response.notice)
            }

        });

        return false;
    });
});

/*************************
 Forms custom processing
 *************************/

function displayError(form, msg) {
    form.parent().find('.msg-block__error').text(msg).fadeIn().delay(3000).fadeOut();
}

function displaySuccess(form, msg) {
    form.parent().find('.msg-block__sucess').text(msg).fadeIn().delay(3000).fadeOut();
    setTimeout(function(){
        form.reset;
        $('.popup__close').click();
    }, 2000);
}

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
 Text Animate
 *************************/
var numText = 0;
var activeSlide = 0;
var widthArray = [];

$(function () {
    numText = $('.text-animate b').length - 1;

    $('.text-animate b').each(function (index, value) {
        widthArray.push($(this).width());
    });

    animateText();

    setInterval(function () {
        animateText();
    }, 3000);

});

function animateText() {
    $('.text-animate .cd-words-wrapper').addClass('w0');

    setTimeout(function () {
        $('.text-animate .cd-words-wrapper').width(widthArray[activeSlide]);

        $('.text-animate b').addClass('is-hidden').removeClass('is-visible');
        $('.text-animate b').eq(activeSlide).removeClass('is-hidden').addClass('is-visible');

        $('.text-animate .cd-words-wrapper').removeClass('w0');
    }, 500);

    if (activeSlide >= numText) {
        activeSlide = 0;
    } else {
        activeSlide++;
    }
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

/*************************
 widget
 *************************/


function widget() {
    $('.iq-widget-menu > ul > li > a').on('click', function () {
        var checkElement = $(this).next();
        $('.iq-widget-menu li').removeClass('active');
        $(this).closest('li').addClass('active');
        if ((checkElement.is('ul')) && (checkElement.is(':visible'))) {
            $(this).closest('li').removeClass('active');
            checkElement.slideUp('normal');
        }
        if ((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
            $('.iq-widget-menu ul ul:visible').slideUp('normal');
            checkElement.slideDown('normal');
        }
        if ($(this).closest('li').find('ul').children().length === 0) {
            return true;
        } else {
            return false;
        }
    });
}

/*************************
 Img Skrollr
 *************************/
function imgskrollr() {
    var mySkrollr = skrollr.init({
        forceHeight: false,
        easings: {
            easeOutBack: function (p, s) {
                s = 1.70158;
                p = p - 1;
                return (p * p * ((s + 1) * p + s) + 1);
            }
        },
        mobileCheck: function () {
            //hack - forces mobile version to be off
            return false;
        }
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
  imgskrollr();
    widget();
    backtotop();
});

$(window).on('load', function () {
    wowanimation();
});




