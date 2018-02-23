import "../../../init/css/style.css.scss";
import "../../../init/css/style.css.scss";
import "../../../init/css/color.css";
import '../../../init/css/googlefonts.css';
import "animate.css/animate.min.css";
import 'owl.carousel/dist/assets/owl.carousel.css';
import "bootstrap/dist/css/bootstrap.min.css";
import "../../../init/fontasome/css/fontawesome-all.min.css";
import "../../../components/callback_form/callback_form";
import './css/style.scss';
import '../../../init/css/responsive.css';
import './js/default';
import "intl-tel-input/build/css/intlTelInput.css";

import './js/jquery.countdown.min';
import './js/yotube';

import 'bootstrap';

require("imports-loader?$=jquery!owl.carousel/dist/owl.carousel.js");
require("imports-loader?$=jquery!intl-tel-input/build/js/intlTelInput.js");

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

/**************************
 Download button
 *************************/
$('.btn-download').click(function () {
   $('.form_lead').removeClass('animated bounceIn');
   setTimeout(function () {
       $('.form_lead').addClass('animated bounceIn');
   },300)

   $('html, body').animate({scrollTop: $('.form_lead').offset().top -25});
});

/**************************
 count down
 *************************/
$(function () {
    var fiveSeconds = new Date().getTime() + ($(".count_down").data('timer') * 1000 * 60);

    $(".count_down")
    .countdown(fiveSeconds, function(event) {
        var $this = $(this).html(event.strftime(''
            + '<div class="col"><span>%H</span>час</div>'
            + '<div class="col"><span>%M</span>мин</div>'
            + '<div class="col"><span>%S</span>сек</div>'));
    }).on('finish.countdown', function () {
        $('.button-container').html('<p class="paragraph">Поздно! Предложение закрыто!</p>');
    });
})

/**************************
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
        navText: ['<div class="i-wrap"><i class="fa fa-angle-left fa-2x"></i></div>', '<div class="i-wrap"><i class="fa fa-angle-right fa-2x"></i></div>'],
        autoplay: $autoplay,
        autoplayHoverPause: true
    });

});
