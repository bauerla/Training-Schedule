class ExercisesController < ApplicationController
  before_action :require_login, only: [:create, :update, :delete, :update_view]

  def create
    @event = Event.find(params[:event_id])
    if @exercise = @event.exercises.create(exercise_params).valid?
      flash.keep[:success] = "New exercise added!"
    else
      flash.keep[:alert] = "Description must be at least 5 characters long & duration integer value"
    end
    redirect_to event_path(@event)
  end

  def update
    @event = Event.find(params[:event_id])
    @exercise = @event.exercises.find(params[:id])
    if @exercise.update(exercise_params)
      flash.keep[:success] = "Exercise updated!"
      redirect_to event_url(@event)
    else
      flash.keep[:warning] = "Check your parameters!"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @exercise = @event.exercises.find(params[:id])
    @exercise.destroy
    flash.keep[:success] = "Exercise deleted!"
    redirect_to event_path(@event)
  end

  def update_view
    @update_ex = Exercise.find(params[:ex_id])
    puts "Event :: "+ @update_ex.inspect
    respond_to do |format|
      format.js
    end
  end

  private
    def exercise_params
      params.require(:exercise).permit(:desc, :duration)
    end

end
