class ExercisesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    if @exercise = @event.exercises.create(exercise_params).valid?
      flash.keep[:success] = "New exercise added!"
    else
      flash.keep[:alert] = "Description must be at least 5 characters long & duration integer value"
    end
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @exercise = @event.exercises.find(params[:id])
    @exercise.destroy
    flash.keep[:success] = "Exercise deleted!"
    redirect_to event_path(@event)
  end

  def update_view
    id = params[:ex_id] # Excercise id if needed
    puts "Event:: " + id
    respond_to do |format|
      format.js
    end
  end

  private
    def exercise_params
      params.require(:exercise).permit(:desc, :duration)
    end

end
