$(document).on('turbolinks:load', function () {
  if (jQuery().datepicker) {
    $('.date-picker').datepicker({
      rtl: App.isRTL(),
      orientation: 'left',
      autoclose: true
    });
    $('.date-picker')
      .find('input[type="text"]')
      .val(I18n.t('signup.birthday'));
  }
});
