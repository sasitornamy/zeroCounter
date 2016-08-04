class Trial < ActiveRecord::Base
  belongs_to :session

  validates :response, numericality: { only_integer: true }

  def update_response_result
    return unless stim_id.present?
    shown_stimulus = Stimulus.find(stim_id)
    correct_response = shown_stimulus.num_zeros
    self.response_result = response == correct_response
  end

  def update_stimulus_order
    return unless session.present?
    self.order_appeared = session.trials.count + 1
  end

end
