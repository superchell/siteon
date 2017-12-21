/*

Template: Sofbox - Responsive Software Landing Page
Author: iqonicthemes.in
Version: 1.0
Design and Developed by: iqonicthemes.in

*/
/*================================================
[  Table of contents  ]
================================================

::page loader
::Back to top
::Amazing Tab
::Accordion
::Header
::Img Skrollr
::Magnific Popup
::countdown
::owl-carousel 
::Progress Bar
::widget
::counter
::Screenshots silder
::Wow Animation

======================================
[ End table content ]
======================================*/

"use strict";


/*************************
page loader
*************************/
function preloader() {
    $("#load").fadeOut();
    $('#loading').delay().fadeOut();
}

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

/*************************
 Popup Initialize
 *************************/
$(function () {
    var animateClass = 'animated slideInDown';

    $('.open-popup-link').click(function (e) {
       e.preventDefault();

       var targetPopup = $(this).attr('href');

       $(targetPopup).addClass('open '+animateClass);
    });

    $('.popup__close, .popup__overlay').click(function (e) {
        if ($(e.target).hasClass('popup__overlay') || $(e.target).hasClass('popup__close') || $(e.target).hasClass('r1') || $(e.target).hasClass('r2') ){
            $('.popup').removeClass('open '+animateClass);
        }
        e.preventDefault();
    });


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







var numText = 0;
var activeSlide = 0;
var widthArray = [];

$(function () {
    numText = $('.text-animate b').length - 1;

    $('.text-animate b').each(function (index, value) {
        widthArray.push($(this).width());
    });

    $(window).resize(function () {
        widthArray = [];
        $('.text-animate b').each(function (index, value) {
            widthArray.push($(this).width());
        });
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
Amazing Tab
*************************/
function Tabbar() {
    $('#iq-amazing-tab').on('click', 'li', function () {
        $('#iq-amazing-tab  li.active1').removeClass('active1');
        $(this).addClass('active1');
    });
}


/*************************
Accordion
*************************/
function accordion() {
    var $acpanel = $(".iq-accordion .ad-block > .ad-details"),
        $acsnav = $(".iq-accordion .ad-block > .ad-title");

    $acpanel.hide().first().slideDown("easeOutExpo");
    $acsnav.first().addClass("ad-active");
    $acsnav.on('click', function () {
        var $this = $(this).next(".ad-details");
        $acsnav.parent().removeClass("ad-active");
        $(this).parent().addClass("ad-active");
        $acpanel.not($this).slideUp("easeInExpo");
        $(this).next().slideDown("easeOutExpo");
        return false;
    });

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




/*************************
countdown
*************************/
function countdown1() {
    $('#countdown').countdown({
        date: '10/01/2018 23:59:59',
        offset: -8,
        day: 'Day',
        days: 'Days'
    }, function () {
        alert('Done!');
    });
}

/*************************
owl-carousel 
*************************/
function owlcarousel() {
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

}

/*************************
Progress Bar
*************************/

function progress() {
    $('.iq-progress-bar > span').each(function () {
        var $this = $(this);
        var width = $(this).data('percent');
        $this.css({
            'transition': 'width 2s'
        });
        setTimeout(function () {
            $this.appear(function () {
                $this.css('width', width + '%');
            });
        }, 500);
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
counter
*************************/

function counter() {
    $('.timer').countTo();
}


/*************************
Screenshots silder
*************************/
function screensilder() {
    var slide = $('.slider-single');
    var slideTotal = slide.length - 1;
    var slideCurrent = -1;

    function slideInitial() {
        slide.addClass('proactivede');
        setTimeout(function () {
            slideRight();
        }, 500);
    }

    function slideRight() {
        if (slideCurrent < slideTotal) {
            slideCurrent++;
        } else {
            slideCurrent = 0;
        }

        if (slideCurrent > 0) {
            var preactiveSlide = slide.eq(slideCurrent - 1);
        } else {
            var preactiveSlide = slide.eq(slideTotal);
        }
        var activeSlide = slide.eq(slideCurrent);
        if (slideCurrent < slideTotal) {
            var proactiveSlide = slide.eq(slideCurrent + 1);
        } else {
            var proactiveSlide = slide.eq(0);

        }

        slide.each(function () {
            var thisSlide = $(this);
            if (thisSlide.hasClass('preactivede')) {
                thisSlide.removeClass('preactivede preactive active proactive').addClass('proactivede');
            }
            if (thisSlide.hasClass('preactive')) {
                thisSlide.removeClass('preactive active proactive proactivede').addClass('preactivede');
            }
        });
        preactiveSlide.removeClass('preactivede active proactive proactivede').addClass('preactive');
        activeSlide.removeClass('preactivede preactive proactive proactivede').addClass('active');
        proactiveSlide.removeClass('preactivede preactive active proactivede').addClass('proactive');
    }

    function slideLeft() {
        if (slideCurrent > 0) {
            slideCurrent--;
        } else {
            slideCurrent = slideTotal;
        }

        if (slideCurrent < slideTotal) {
            var proactiveSlide = slide.eq(slideCurrent + 1);
        } else {
            var proactiveSlide = slide.eq(0);
        }
        var activeSlide = slide.eq(slideCurrent);
        if (slideCurrent > 0) {
            var preactiveSlide = slide.eq(slideCurrent - 1);
        } else {
            var preactiveSlide = slide.eq(slideTotal);
        }
        slide.each(function () {
            var thisSlide = $(this);
            if (thisSlide.hasClass('proactivede')) {
                thisSlide.removeClass('preactive active proactive proactivede').addClass('preactivede');
            }
            if (thisSlide.hasClass('proactive')) {
                thisSlide.removeClass('preactivede preactive active proactive').addClass('proactivede');
            }
        });
        preactiveSlide.removeClass('preactivede active proactive proactivede').addClass('preactive');
        activeSlide.removeClass('preactivede preactive proactive proactivede').addClass('active');
        proactiveSlide.removeClass('preactivede preactive active proactivede').addClass('proactive');
    }

    var left = $('.slider-left');
    var right = $('.slider-right');
    left.on('click', function () {
        slideLeft();
    });
    right.on('click', function () {
        slideRight();
    });
    slideInitial();
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
All function are called here 
*************************/
$(document).ready(function () {
    backtotop(),
        owlcarousel(),
        accordion(),
        imgskrollr(),
        preloader(),
        Tabbar(),
        header(),
        progress(),
        widget(),
        screensilder(),
        counter();
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

function initScroll() {
  $('a.page-scroll').on('click', function (e) {
    var anchor = $(this);
    if (anchor.attr('href').match('#') === null)
        return;
    $('html, body').stop().animate({
      scrollTop: $(anchor.attr('href')).offset().top - 50
    }, 1500);
    e.preventDefault();
  });
}