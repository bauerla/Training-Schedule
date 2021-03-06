class ExercisesController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy, :update_view]

  # Create bew Exercise
  def create
    @event = Event.find(params[:event_id])
    if @exercise = @event.exercises.create(exercise_params).valid?
      flash.keep[:success] = "New exercise added!"
    else
      flash.keep[:alert] = "Description must be at least 5 characters long & duration integer value"
    end
    redirect_to event_path(@event)
  end

  # Update Exercise
  def update
    @event = Event.find(params[:event_id])
    @exercise = @event.exercises.find(params[:id])
    if @exercise.update(exercise_params)
      flash.keep[:success] = "Exercise updated!"
      redirect_to event_path(@event)
    else
      flash.keep[:warning] = "Check your parameters!"
    end
  end

  # Remove Exercise
  def destroy
    @event = Event.find(params[:event_id])
    @exercise = @event.exercises.find(params[:id])
    @exercise.destroy
    flash.keep[:success] = "Exercise deleted!"
    redirect_to event_path(@event)
  end

  # Update view handling
  def update_view
    @update_ex = Exercise.find(params[:ex_id])
    respond_to do |format|
      format.js
    end
  end

  private
    # Validate Exercise params
    def exercise_params
      params.require(:exercise).permit(:desc, :duration)
    end

end
