class NotificationsController < ApplicationController
  def update
    unseen_noti = Notification.by_user(current_user).not_seen
    return if unseen_noti.blank?

    unseen_noti.update_all status: :seen
  end
end
