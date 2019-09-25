module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base.title"

    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_date date
    l date
  end

  def format_time time
    l time, format: :short
  end

  def calculate_age date
    ((Time.zone.now - date.to_time) / 1.year.seconds).floor
  end

  def seen_at_display message, user
    (message.user.eql?(user) &&  message.seen?) ? t("chat.seen_at") : ""
  end

  def select_class_message message, user
    message.user.eql?(user) ? "message-sent" : "message-received"
  end

  def text_class_message message, user
    message.user.eql?(user) ? "text-right" : "text-left"
  end

  def show_time_message message
    I18n.l(message.created_at, format: :short)
  end
end
