class EventsController < ApplicationController
  before_action :require_login, only: [:new, :edit, :create, :update, :destroy]
  # before_action "get_previous_url", only: [:show, :new, :edit]
  before_action :load_nav
  after_action  :set_nav, only: [:show]
	helper_method :youtube_embed, :is_completed

  # Show all Events
	def index
		@events = Event.order('starttime')
	end

  # Show Event
	def show
		@event = Event.find(params[:id])
	end

  # Define new Event
	def new
		@event = Event.new
    @video = @event.build_video
	end

  # Edit Event
	def edit
		@event = Event.find(params[:id])
	end

  # Create new Event
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

  # Update Event
	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			flash.now[:success] = "Event updated!"
      render 'show'
		else
			render 'edit'
		end
	end

  # Mark event as completed and update database
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

  # Remove Event
	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to request.referrer
	end

  # return boolean if event marked as completed
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

	private
    # Validate event params when creating new
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

    # Validate params when completing Event
    def event_done_params
      params.require(:event).permit(:compeleted,
                                    :done_summary,
                                    :done_additional,
                                    :done_created_at)
    end

    # Load back navigatio path
    def load_nav
      url_params = Rails.application.routes.recognize_path(request.referer)
      if url_params[:controller] == 'events' && url_params[:action] == 'show'
        @nav_to = session[:nav_to] 
      else
        @nav_to = request.referrer
      end
      puts "NAV_TO load_nav -> #{@nav_to}"
      if @nav_to == calendar_path
        @date_from_url ||= params[:date]
        starttime_date ||= @date_from_url
      else
        @date_from_url ||= url_params[:date]
      end
    end

    # Save url navigated from
    def set_nav
      url_params = Rails.application.routes.recognize_path(request.referer)
      puts "Url params: #{url_params}"
      ctrl = url_params[:controller]
      if ctrl != 'events' || (ctrl == 'events' && url_params[:action] != 'show')
        case  ctrl
        when 'calendar'
          session[:nav_to] = calendar_path
        when 'daily'
          session[:nav_to] = daily_p_path(params[:date] || url_params[:date])
        when 'events'
          session[:nav_to] = events_path
        end
      end
    end
end
