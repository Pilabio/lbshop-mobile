$(function() {
  $('.js-submit-link').on('click', function() {
    inputVal = $('.js-form-input').val();
    $('.js-form-input--hidden').val(' ' + inputVal)

    $('#attribute-inline-form').submit();
  })
});
