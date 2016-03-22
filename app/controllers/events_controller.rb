class EventsController < ApplicationController

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
			redirect_to @event, :notice => "Event updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		flash.now[:alert] = "Event deleted!"
		redirect_to events_path
	end

	private
	def event_params
		#@start_time = Time.zone.local(*params[:starttime].sort.map(&:last).map(&:to_i))
		#@end_time = Time.zone.local(*params[:endtime].sort.map(&:last).map(&:to_i))
		params.require(:event).permit(:title, :text, :starttime, :endtime, :starttime_time, :endtime_time, :starttime_date, :endtime_date)
	end
end
