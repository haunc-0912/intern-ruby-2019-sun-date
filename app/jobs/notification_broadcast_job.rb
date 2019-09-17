class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform count, notification
    ActionCable.server.broadcast "notify_channel_#{notification.recipient_id}", counter: render_counter(count), notification: render_notification(notification)
  end

  private

  def render_counter count
    ApplicationController.renderer.render(partial: "layouts/count_notification", locals: { count_notification: count })
  end

  def render_notification notification
    ApplicationController.renderer.render(partial: "layouts/notification", locals: { notification: notification })
  end
end
