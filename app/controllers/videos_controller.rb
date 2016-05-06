class VideosController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

  def create
    puts "VideosController - create"
    @event = Event.find(params[:event_id])
    if @video = @event.create_video(video_params).valid?
      flash.keep[:success] = "New video added!"
    else
      flash.keep[:alert] = "Cannot add video! -> Check your video link"
    end
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
      flash.keep[:warning] = "Cannot update -> Check your video link!"
    end
  end

  def destroy
    puts "VideosController - destroy"
    @event = Event.find(params[:event_id])
    @video = @event.videos.find(params[:id])
    @video.destroy
    flash.keep[:success] = "video deleted!"
    redirect_to event_path(@event)
  end

  private
    def video_params
      params.require(:video).permit(:link, :title, :published_at)
    end
end
