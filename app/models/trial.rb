class Trial < ActiveRecord::Base
  belongs_to :experiment_session
  belongs_to :stimulus
  has_one :trial_interaction

  validates :response, numericality: { only_integer: true }

  def create_or_update_interaction(interaction_params)
    @interaction_params = OpenStruct.new(interaction_params)
    @interaction = TrialInteraction.find_or_initialize_by(trial_id: self.id)
    @interaction.update_attributes(interaction_attributes)
  end

  private

  def interaction_attributes
    {
      keystrokes: @interaction_params.keystrokes || @interaction.keystrokes,
      response_time:
        time_until_now_in_msec(
          @interaction_params.trial_start_time
        ) || @interaction.response_time,
      time_since_answer_revealed_to_next_question:
        time_until_now_in_msec(
          @interaction_params.answer_revealed_time
        ) || @interaction.time_since_answer_revealed_to_next_question
    }
  end

  def time_until_now_in_msec(start_time)
    return unless start_time.present?
    (Time.now - start_time.to_time) * 1000
  end

end
