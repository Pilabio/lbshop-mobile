$(document).on('turbolinks:load', function() {
  $models = $('.js-query-model');

  $models.each(function (index) {
    modelId = $(this).data('id');

    $(this).find('.js-query-link').attr('href', 'products?utf8=✓&q%5Bclient_id_eq%5D=' + modelId)
  });
});
