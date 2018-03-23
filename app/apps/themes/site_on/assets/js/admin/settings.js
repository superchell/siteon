jQuery(document).on("ready page:changed", function(){
  var settings_form = $("#theme_settings_form");

  settings_form.submit(function(){
    var scroll_target = undefined;

    $(this).find('.error').each(function () {
      var panel = $(this).closest('.panel');
      if (scroll_target == undefined) scroll_target = panel;

      if (panel.hasClass('panel-toggled')) {
        panel.removeClass("panel-toggled");
        panel.find(".panel-collapse .fa-angle-up").removeClass("fa-angle-up").addClass("fa-angle-down");
      }
    })

    scroll_to_elem(scroll_target, 500);
  });

  $('#theme_settings_form .panel-collapse').click(function () {
    var panel = $(this).closest('.panel'),
        footer = $('.panel-footer');

    if (panel.hasClass('panel-toggled')) {
      footer.addClass('fixed-button');
    }
  })
});

function scroll_to_elem(elem, speed) {
  var destination = $(elem).offset().top;
  $("html,body").animate({scrollTop: destination}, speed);
}

function initCustomFieldEditor(field, value) {
  if (field)
  {
    field.val(value);
    var id = "t_" + Math.floor((Math.random() * 100000) + 1) + "_area";
    var textarea = field.attr('id', id);

    if (textarea.hasClass('is_translate')) {
      textarea.addClass('translatable').Translatable(ADMIN_TRANSLATIONS);
      var inputs = textarea.data("translation_inputs");
      if (inputs) { // multiples languages
        for (var lang in inputs) {
          tinymce.init(cama_get_tinymce_settings({
            selector: '#' + inputs[lang].attr("id"),
            height: 120
          }));
        }
        return;
      }
    }
    tinymce.init(cama_get_tinymce_settings({
      selector: '#' + id,
      height: 120
    }));
  }
}