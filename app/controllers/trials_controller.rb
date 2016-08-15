class TrialsController < ApplicationController

  def new
    @stimulus = Stimulus.next_remaining(
      params[:experiment_session_id],
      params[:order_appeared]
    )
    unless @stimulus.present?
      @experiment_session = ExperimentSession.find(params[:experiment_session_id])
      @experiment_session.number_of_trials = params[:order_appeared]
      return render 'experiment_sessions/complete'
    end

    @trial = Trial.new
    @trial.stimulus_id = @stimulus.id
    @trial.experiment_session_id = params[:experiment_session_id]
  end

  def create
    @trial = TrialBuilder.new(trial_params).build
    @stimulus = Stimulus.find(@trial.stimulus_id)

    unless @trial.save
      flash.now[:error] = @trial.errors.full_messages[0]
      @trial.response_result = nil
    end
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
