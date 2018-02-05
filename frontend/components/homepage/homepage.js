import "./homepage.css";

import "./home_baner/home_baner";
import "./how_works/how_works";
import "./who_we/who_we";
import "./portfolio/portfolio";
import "./reviews/reviews";
import "./services/services";
import "./counters/counters";
import "./tech/tech";
import "./prices/prices";
import "./working/working";
import "./brands/brands";

import TweenMax from 'gsap';
import ScrollToPlugin from "gsap/ScrollToPlugin";

var items_links = $('#main_menu').find('.menu-item > a');

if ($('.home-page').length != 0) {
    $(items_links).on('click', function (event) {
        event.preventDefault();
        var href = $(this).attr('href');
        scroller(href);
        if( $('.collapse.in').lenght !=0){
            $('.collapse.in').removeClass('in');
        }
    });
}
function scroller(href){
    var scrollYPos = $(href).offset().top;
    TweenLite.to(window, 1, {scrollTo:{y:scrollYPos, x:0}, ease:Expo.easeOut});
}