module ApplicationHelper

	# Bootstrap custom types for flash (message)
	def bootstrap_icon_for flash_type
    { success: "ok-circle", error: "remove-circle", alert: "warning-sign", notice: "exclamation-sign" }[flash_type.to_sym] || "question-sign"
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
	end

  # Helper for display readable date
  def parse_date(date)
    date.empty? ? "" : date = date.to_date.to_formatted_s(:rfc822)
  end

  def get_timestamp(date)
    puts date.to_datetime
    if date.to_datetime > 1.day.ago
      date = time_difference(date.to_time, Time.now)
    else
      date = "#{distance_of_time_in_words_to_now(date.to_datetime)} ago"
      #date = date.strftime("%e %b %Y at %M:%H")
    end
  end

  private
    def time_difference(start_time, end_time)
      seconds_diff = (start_time - end_time).to_i.abs
      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600
      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60
      seconds = seconds_diff

      if hours != 0
        puts "tuntei"
        "#{pluralize(hours, 'hour')} #{pluralize(minutes, 'minute')} ago"
      elsif minutes != 0
        puts "minuuttei"
        "#{pluralize(minutes, 'minute')} ago"
      else
        puts "sekuntei"
        "#{pluralize(seconds, 'second')} ago"
      end
    end

end
