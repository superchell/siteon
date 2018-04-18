import "./header.scss";

$('.header-top_phones .dropdown-link').click(function () {

    if ( $(this).parent().hasClass('open') ){
        document.location.href = $(this).attr('href');
    }

});