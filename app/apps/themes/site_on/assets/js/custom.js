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