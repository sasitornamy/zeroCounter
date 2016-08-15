class ExperimentSession < ActiveRecord::Base
  belongs_to :user
  has_many :trials
  has_many :stimuli, through: :trials

  validates_acceptance_of :consent_given, accept: true, allow_nil: false
  validates_format_of :mechanical_turk_id, with: /\A[A-Za-z0-9]+\z/, on: :update
end
