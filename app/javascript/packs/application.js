// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// Rellena select de modelos cando se modifica a marca no formulario de dispositivos
$(document).ready(function() {
  $("#device_brand_id").on('change', function(){
    // Limpiar listado
    $("#device_model_id").children().remove();
    // Opción en branco
    $("#device_model_id").append(`<option value=""></option>`);
    // Si o valor seleccionado non está baleiro facemos a búsqueda
    if ($(this).val() != ""){
      // Recuperar listado de modelos en base a marca seleccionada
      $.ajax({
        url: "/devices/models_for_select_brand",
        type: "GET",
        data: {brand_id: $(this).val()},
        success: function(data) {
          // Crear opción e engadilas a lista
          $.each(data, function(k, v) {
            $("#device_model_id").append(`<option value="${v.id}">${v.description}</option>`);
          });
        },
        error: function() {
          console.log('Sin datos')
        }
      })
    }
  });
})