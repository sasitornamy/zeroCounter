class TrialBuilder

  def initialize(trial_params)
    @trial = Trial.new(trial_params)
    trial_params = OpenStruct.new(trial_params)
    @experiment_session_id = trial_params.experiment_session_id
    @stimulus_id = trial_params.stimulus_id
    @response = trial_params.response
  end

  def build
    update_response_result
    update_stimulus_order
    @trial
  end

  def update_response_result
    return unless @stimulus_id.present?
    current_stimulus = Stimulus.find_by_id(@stimulus_id)
    if current_stimulus.present?
      correct_response = current_stimulus.number_of_zeros
      @trial.response_result = @response.to_s == correct_response.to_s
    end
  end

  def update_stimulus_order
    return unless @experiment_session_id.present?
    experiment_session = ExperimentSession.find_by_id(
      @experiment_session_id
    )
    if experiment_session.present?
      @trial.order_appeared = experiment_session.trials.count + 1
    end
  end
end
