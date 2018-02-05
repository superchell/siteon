import "./portfolio.css";

require("imports-loader?$=jquery!jquery-viewport-checker-gena/dist/jquery.viewportchecker.min");


$(function () {
    $('.view-check').viewportChecker({
        offset: '30%'
    });
});