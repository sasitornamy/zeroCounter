class ExperimentSession < ActiveRecord::Base
  belongs_to :user
  has_many :trials
  has_many :stimuli, through: :trials

  validates_acceptance_of :consent_given, accept: true, allow_nil: false
end
