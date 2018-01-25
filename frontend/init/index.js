import "./css/index.css";

("use strict");

import $ from "jquery";
import jQuery from "jquery";
window.$ = jQuery;

/*************************
 page loader
 *************************/
function preloader() {
  $("#load").fadeOut();
  $("#loading")
    .delay()
    .fadeOut();
}

$(document).ready(function() {
  preloader();
});
