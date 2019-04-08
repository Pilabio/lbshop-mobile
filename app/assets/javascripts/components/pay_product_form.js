$(document).on('turbolinks:load', function () {
  $('.js-btn-payment').each(function () {
    $(this).on('click', function () {
      $('.form_modal_product').attr('value', $(this).data('resource'))
    })
  })
})
