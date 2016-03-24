class ExercisesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    if @exercise = @event.exercises.create(exercise_params).valid?
      flash.keep[:success] = "New exercise added: #{@exercise.desc}"
      puts "joo -------------------------------"
    else
      flash.keep[:error] = "Description must be at least 5 characters long & duration integer value"
      puts "ei -------------------------------"
    end
    redirect_to event_path(@event)
  end

  private
    def exercise_params
      params.require(:exercise).permit(:desc, :duration)
    end

end
