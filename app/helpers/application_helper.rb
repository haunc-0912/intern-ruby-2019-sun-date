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

  def calculate_age date
    ((Time.zone.now - date.to_time) / 1.year.seconds).floor
  end
end
