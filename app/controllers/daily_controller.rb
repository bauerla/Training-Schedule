require 'date'

class DailyController < ApplicationController
  def index
    @date_string = ""
    @events = Array.new
    @date = params[:date]
    # use Date extension to validate date
    if Date.parsable?(@date)
      puts "Date was - #{@date}"
      @events = Event.daily_events(@date.to_date)
      @date_string = parse_date(@date)
    end
    puts @events.inspect
  end

  private
    def parse_date(date)
      date.empty? ? "" : date = date.to_date.to_formatted_s(:rfc822)
    end
end
