import 'jquery.cookie';

global.saveUserGetresnose = function(mail){
    $.cookie('user_email', mail, { expires: 1, path: '/' });

    return 'user coocke saved';
}

function getresponseTegUser(email, teg) {

}

$( ".getresponce_form" ).submit(function( event ) {
    saveUserGetresnose( $( ".getresponce_form" ).find('input[name="email"]').val() );
});

$( ".validate-form" ).submit(function( event ) {
    var parentBlock = $( ".validate-form" ).parent('.getresponce_tag');

    if (parentBlock.length != 0){
        var email = $( ".validate-form" ).find('input[name="email"]').val();
        $.get( "https://siteon.com.ua/set_contact_tag", { email: email, tag: "lp_consulting" } );
    }
});
