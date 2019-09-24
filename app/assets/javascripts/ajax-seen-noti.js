$(document).on('turbolinks:load', function () {
  $('#header_notification_bar').on('mouseenter', function () {
    $('#notification-counter').html("0");
    $.ajax({
      url: 'notifications/update'
    });
  });
});
