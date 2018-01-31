import "./working.css";


/*************************
 Accordion
 *************************/
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