class TrialsController < ApplicationController
  before_action :update_previous_trial_interaction, only: :new

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
    @trial_start_time = Time.now
  end

  def create
    @trial = TrialBuilder.new(trial_params).build
    @stimulus = Stimulus.find(@trial.stimulus_id)
    @trial_start_time = params[:trial_start_time]
    @keystrokes = params[:keystrokes]

    if @trial.save
      @trial.create_or_update_interaction(trial_interaction_params)
      @answer_revealed_time = Time.now
    else
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

  def trial_interaction_params
    params.permit(
      :answer_revealed_time,
      :trial_start_time,
      :keystrokes
    )
  end

  def update_previous_trial_interaction
    return unless params[:previous_trial_id].present?
    previous_trial = Trial.find(params[:previous_trial_id])
    previous_trial.create_or_update_interaction(trial_interaction_params)
  end
end
