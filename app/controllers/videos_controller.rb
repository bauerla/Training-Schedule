class VideosController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

  def create
    puts "VideosController - create"
    @event = Event.find(params[:event_id])
    if @video = @event.create_video(video_params).valid?
      flash.keep[:success] = "New video saved!"
    else
      flash.keep[:alert] = "Cannot add video - Check your video link!"
    end
    redirect_to request.referrer
  end

  def update
    puts "VideosController - update"
    @event = Event.find(params[:event_id])
    @video = @event.video
    puts video_params[:link]
    puts @video.link
    if @video.link == video_params[:link]
      flash.keep[:alert] = "Video already exists!"
    else
      if @video.update_attributes(video_params)
        flash.keep[:success] = "Video updated!"
      else
        flash.keep[:alert] = "Cannot update - Check your video link!"
      end
    end
    redirect_to request.referrer
  end

  def destroy
    puts "VideosController - destroy"
    @event = Event.find(params[:event_id])
    @video = @event.video
    @video.delete
    flash.keep[:success] = "Video deleted!"
    redirect_to request.referrer
  end

  private
    def video_params
      params.require(:video).permit(:link, :title, :published_at)
    end
end
