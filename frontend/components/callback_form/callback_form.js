import "./callback_form.css";

$(function(){
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
});