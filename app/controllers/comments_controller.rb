class CommentsController < ApplicationController
  before_action :require_login, only: [:destroy]

  # Create comment
  def create
    @event = Event.find(params[:event_id])
    if @comment = @event.comments.create(comment_params).valid?
      flash.keep[:success] = "New comment added!"
    else
      flash.keep[:alert] = "Name must be at least 2 characters & comment can't be blank"
    end
    redirect_to event_path(@event)
  end

  # Remove comment
  def destroy
    @event = Event.find(params[:event_id])
    @comment = @event.comments.find(params[:id])
    if @comment.delete
      flash.keep[:success] = "Comment removed!"
      redirect_to event_path(@event)
    else
      flash.keep[:error] = "Couldn't remove comment!"
      redirect_to event_path(@event)
    end
  end

  private
    # Validate params
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
