require 'date'

class CalendarController < ApplicationController

	def index
	end

	# Show Calendar
	def show
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		logger.debug @date.beginning_of_day

		#@events_by_date = Event.current_day(@date) # Should change to fetch month at a time ?
		puts '----- Events: ------'
		@events_by_date = Event.order(:starttime)
		logger.debug @events_by_date.inspect
		puts '--------------------'

	end

end
