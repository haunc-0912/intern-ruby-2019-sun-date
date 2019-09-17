class NotifyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notify_channel_#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
