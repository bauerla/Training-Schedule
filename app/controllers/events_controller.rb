class EventsController < ApplicationController
	#event = Event.new
	#event.starttime = @starttime
	#event.endtime = @endtime

	def index
		@events = Event.all
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
			render 'show'
		else
			render 'new'
		end
	end

	def update
		@event = Event.find(params[:id])

		if @event.update(event_params)
			redirect_to @event
		else
			render 'edit'
		end
	end

	private
	def event_params
		#@start_time = Time.zone.local(*params[:starttime].sort.map(&:last).map(&:to_i))
		#@end_time = Time.zone.local(*params[:endtime].sort.map(&:last).map(&:to_i))
		params.require(:event).permit(:title, :text, :starttime, :endtime)
	end
end
