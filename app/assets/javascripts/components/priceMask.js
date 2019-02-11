$(document).on('turbolinks:load', function() {
  $('.js-br-price').priceFormat({
      prefix: 'R$ ',
      centsSeparator: ',',
      thousandsSeparator: '.'
  });

  $('.js-nested-transform-value').on('input', function() {
    var $this = $(this);
    value = $this.val() ? Number($this.val().replace(/[^0-9\.]+/g,"")) : 0
    $this.closest('.js-parent-transform').find($this.data('target')).val(value);
  });
})
