$(function() {
  $('.js-index-submit-link').on('click', function() {
    $('#index-inline-form').submit();
  });
});

$( document ).on('turbolinks:load', function() {
  $('.js-submit-link').each(function (index) {
    $(this).on('click', function (){
      key = $(this).data('key')
      $ancestor = $(this).parent()
      inputVal = $ancestor.siblings('.js-input').val();

      if (inputVal === "") return;

      $ancestor.siblings('.hidden').children('.js-input--hidden').val(' ' + inputVal);
      $(`#js-${key}-inline-form`).submit();
    })
  });
});
