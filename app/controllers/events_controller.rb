class EventsController < ApplicationController

	helper_method :parse_date

	def index
		@events = Event.order('starttime')
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def edit
		@event = Event.find(params[:id])
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			#redirect_to @event
			flash.now[:success] = "New Event Added!"
			render 'show'
		else
			render 'new'
		end
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			redirect_to @event, :success => "Event updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to events_path
	end

	# Helper for display readable date
	def parse_date(date)
    date.empty? ? "" : date = date.to_date.to_formatted_s(:rfc822)
  end

	private
	def event_params
		params.require(:event).permit(:title, :text, :starttime, :endtime, :starttime_time, :endtime_time, :starttime_date, :endtime_date)
	end
end
