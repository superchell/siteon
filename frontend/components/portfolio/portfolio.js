import "./portfolio.css";

require("imports-loader?$=jquery!jquery-viewport-checker-gena/dist/jquery.viewportchecker.min");

var items = $('#main_menu').find('.menu-item > a');

if ($('.portfolio-page').length != 0){
    items.each(function(){1
        if ($(this).attr('href').match('#') !== null)
            $(this).attr('href', "/" + $(this).attr('href'))
    });
}


$(function () {
    $('.view-check').viewportChecker({
        offset: '30%'
    });
});