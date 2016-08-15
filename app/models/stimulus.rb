class Stimulus < ActiveRecord::Base
  has_many :trials
  has_many :experiment_sessions, through: :trials

  scope :random, -> { order('RANDOM()') }
  scope :excluded_id, -> (ids) { where.not(id: ids) }

  def self.next_remaining(experiment_session_id, trial_order)
    return unless trial_order.to_i < ENV['NUMBER_OF_TRIALS'].to_i
    completed_stimulus_ids = []
    current_session = ExperimentSession.find(experiment_session_id)
    current_session.stimuli.each do |s|
      completed_stimulus_ids.push(s.id)
    end
    Stimulus.excluded_id(completed_stimulus_ids).random.first
  end
end
