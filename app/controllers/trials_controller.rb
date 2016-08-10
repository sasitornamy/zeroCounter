class TrialsController < ApplicationController

  def new
    completed_stimulus_ids = []
    ExperimentSession.find(params[:experiment_session_id]).stimuli.each do |s|
      completed_stimulus_ids.push(s.id)
    end
    @stimulus = Stimulus.excluded_id(completed_stimulus_ids).random.first
    return render :complete unless @stimulus

    @trial = Trial.new
    @trial.stimulus_id = @stimulus.id
    @trial.experiment_session_id = params[:experiment_session_id]
  end

  def create
    @trial = TrialBuilder.new(trial_params).build
    @stimulus = Stimulus.find(@trial.stimulus_id)

    flash.now[:error] = @trial.errors.full_messages[0] unless @trial.save
    render :new
  end

  private

  def trial_params
    params.require(:trial).permit(
      :experiment_session_id,
      :stimulus_id,
      :response
    )
  end
end
