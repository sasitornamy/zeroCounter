class Trial < ActiveRecord::Base
  belongs_to :experiment_session
  belongs_to :stimulus
  has_one :trial_interaction

  validates :response, numericality: { only_integer: true }

  def update_trial_interaction(trial_interaction_params)
    trial_interaction_params = OpenStruct.new(trial_interaction_params)
    if trial_interaction.present?
      trial_interaction.update(
        time_since_answer_revealed_to_next_question:
          time_duration_in_msec(
            trial_interaction_params.answer_revealed_time.to_time,
            Time.now
          )
      )
    else
      create_trial_interaction(
        keystrokes: trial_interaction_params.keystrokes,
        response_time:
          time_duration_in_msec(
            trial_interaction_params.trial_start_time.to_time,
            Time.now
          )
      )
    end
  end

  private

  def time_duration_in_msec(start_time, end_time)
    (end_time - start_time) * 1000
  end

end
