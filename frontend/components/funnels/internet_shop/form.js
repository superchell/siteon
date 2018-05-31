import isEmail from 'validator/lib/isEmail';
import isEmpty from 'validator/lib/isEmpty';
import Inputmask from "inputmask";


let maskInput = $('input[type="tel"]');
maskInput.each(function (index,item) {
    Inputmask({"mask": "+38(999)9999999", clearMaskOnLostFocus: true}).mask(item);
});


$('.validate-form').on('submit', function (e) {
    let $form = $(this);
    let $errorMsg = '';

    $form.find('input').each(function (index, item) {
        let itemVal = $(this).val();

        if ($(this).attr('required')){
            if (isEmpty(itemVal)) {
                $(this).addClass('error-field');
                $(this).parent().find('.angle-docore').addClass('error');

                $errorMsg += "Поле обязательно к заполнению";
                return false;
            } else {
                $(this).removeClass('error-field');
                $('.msg-block__sucess').removeClass('show');
            }
        }

        if ($(this).attr('type') == 'tel') {
            let checkString = itemVal.replace(/_/g, '');
            if (checkString.length < 15) {
                $(this).addClass('error-field');
                $(this).parent().find('.angle-docore').addClass('error');

                $errorMsg += "Не верно введен номер";

            } else {
                $(this).removeClass('error-field');
                $('.msg-block__sucess').removeClass('show');
            }
        }

        if ($(this).attr('type') == 'email') {
            if (!isEmail(itemVal)) {
                $(this).addClass('error-field');
                $(this).parent().find('.angle-docore').addClass('error');

                $errorMsg += "Неверно введен Email";
            } else {
                $(this).removeClass('error-field');
                $('.msg-block__sucess').removeClass('show');
            }
        }
    });

    if ($errorMsg != '') {
        displayError($form, $errorMsg);
        return false;
    } else {
        $.post($form.attr('action'), $form.serialize(), function (response) {
            hideMessages($form);
            if (response.error != undefined) {
                displayError($form, response.error);
                return false
            }
            if (response.notice != undefined) {
                $form.trigger("reset");
                $form.find('.form-visible-content').hide();
                $form.find('.msg-block').show();
                TweenMax.set('.success-form-block-hide',{display: 'block'});
            }
        });
    }

    return false;
});

$('.close-info').click(function () {
    $('.success-form-block-hide, .hide-form').fadeOut();
   return false;
});

global.displayError = function (form, msg) {
    form.find('.w-form-fail').show();
    form.parent().find('.msg-block__error').html(msg).addClass('show');
}

global.displaySuccess = function (form, msg) {
    successOpen();
    form.find('.w-form-fail').hide();
    form.find('.w-form-done').show();
    form.parent().find('.msg-block__sucess').html(msg);
}

global.hideMessages = function (form) {
    form.parent().find('.msg-block__error').removeClass('show');
    form.parent().find('.msg-block__sucess').removeClass('show');
}

function successOpen() {
    $('.success-msg').removeClass('hide');

    $('.hide-success-element').hide();

    let checkTween =  new TimelineMax({ repeat: 0 });
    checkTween.set('#path852, #path854', {
        drawSVG:'0% 0%'
    }).to('#path854', 0.5, {
        drawSVG: '0% 100%'
    }).to('#path852', 0.5, {
        drawSVG: '0% 100%'
    });

    TweenMax.to($('.success-msg'),0.5,{opacity:1})
}