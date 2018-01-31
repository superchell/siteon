import "./services.css";


/*************************
 Amazing Tab
 *************************/
$('#iq-amazing-tab').on('click', 'li', function () {
    $('#iq-amazing-tab  li.active1').removeClass('active1');
    $(this).addClass('active1');
});