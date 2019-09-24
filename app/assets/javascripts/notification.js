App.notifications = App.cable.subscriptions.create({
    channel: 'NotifyChannel'
  },
  {
    connected: function () {
    },
    disconnected: function () {
    },
    received: function (data) {
      this.update_counter(data.counter);
      this.update_notifications(data.notification);
    },
    update_counter: function (counter) {
      var $counter;
      $counter = $('#notification-counter-wrap');
      return $counter.html(counter);
    },
    update_notifications: function (notification) {
      var $notification = $('#notification-box');
      return $notification.prepend(notification);
    }
  });
