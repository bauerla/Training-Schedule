class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    if @comment = @event.comments.create(comment_params).valid?
      flash.keep[:success] = "New comment added!"
    else
      flash.keep[:alert] = "Name must be over 2 characters long and comment not empty"
    end
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @comment = @event.comments.find(params[:id])
    @comment.delete
    flash.keep[:success] = "Comment removed!"
    redirect_to event_path(@event)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
