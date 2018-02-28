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

$( ".getresponce_form_teg" ).submit(function( event ) {

});
