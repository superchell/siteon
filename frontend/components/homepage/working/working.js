import "./working.css";


/*************************
 Accordion
 *************************/
var $acpanel = $(".iq-accordion .tab-block > .tab-details"),
    $acsnav = $(".iq-accordion .tab-block > .tab-title");

$acpanel.hide().first().slideDown("easeOutExpo");
$acsnav.first().addClass("tab-active");
$acsnav.on('click', function () {
    var $this = $(this).next(".tab-details");
    $acsnav.parent().removeClass("tab-active");
    $(this).parent().addClass("tab-active");
    $acpanel.not($this).slideUp("easeInExpo");
    $(this).next().slideDown("easeOutExpo");
    return false;
});