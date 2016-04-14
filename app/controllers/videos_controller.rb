class VideosController < ApplicationController

  def create
    puts "VideosController - create"
    @event = Event.find(params[:event_id])
    if @video = @event.create_video(video_params).valid?
      flash.keep[:success] = "New video added!"
    else
      flash.keep[:alert] = "Description must be at least 5 characters long & duration integer value"
    end
    redirect_to event_path(@event)
  end

  def destroy
    puts "VideosController - destroy"
    @event = Event.find(params[:event_id])
    @video = @event.videos.find(params[:id])
    @video.destroy
    flash.keep[:success] = "video deleted!"
    redirect_to event_path(@event)
  end

  def update
    puts "VideosController - update"
    @event = Event.find(params[:event_id])
    @video = @event.video
    if @video.update_attributes(video_params)
      flash.keep[:success] = "video updated!"
      redirect_to event_url(@event)
    else
      flash.keep[:warning] = "Check your parameters!"
    end
  end

  private
    def video_params
      params.require(:video).permit(:link, :title, :published_at)
    end
end
