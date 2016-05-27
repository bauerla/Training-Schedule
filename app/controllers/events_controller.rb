class EventsController < ApplicationController
  before_action :require_login, only: [:new, :edit, :create, :update, :destroy]
  before_action "get_previous_url", only: [:show, :new, :edit]
	helper_method :youtube_embed, :is_completed

	def index
		@events = Event.order('starttime')
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
    @video = @event.build_video
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
			flash.now[:success] = "Event updated!"
      render 'show'
		else
			render 'edit'
		end
	end

  def event_done
    event = Event.find(params[:event_id])
    event.completed = true
    event.done_created_at = DateTime.now
    puts "params: #{event_done_params}"
    if event.update(event_done_params)
      flash.now[:success] = "Event updated!"
      redirect_to event_path(event)
    else
      flash.now[:error] = "Something went wrong!"
    end
  end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to request.referrer
	end

  def is_completed
    is_completed = @event.completed
  end

  # Retrieve Youtube video inside iframe
  def youtube_embed(youtube_url)
  if youtube_url[/youtu\.be\/([^\?]*)/]
    youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end
    html = ""
    html += %Q{<iframe title="YouTube video player" width="auto" height="auto" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
    html.html_safe
  end

  # Save url navigated from
  def get_previous_url
    @url_params = Rails.application.routes.recognize_path(request.referer)
    @prev_ctrl = @url_params[:controller]
    if @prev_ctrl == "calendar"
      @date_from_url ||= params[:date]
      starttime_date ||= @date_from_url
    else
      @date_from_url ||= @url_params[:date]
    end
    puts @prev_ctrl
    puts @url_params
    puts @date_from_url
  end

	private
  	def event_params
  		params.require(:event).permit(:title,
                                    :text,
                                    :starttime,
                                    :endtime,
                                    :starttime_time,
                                    :starttime_date,
                                    :endtime_time,
                                    :endtime_date)
  	end

    def event_done_params
      params.require(:event).permit(:compeleted,
                                    :done_summary,
                                    :done_additional,
                                    :done_created_at)
    end
end
