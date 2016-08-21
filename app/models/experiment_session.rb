class ExperimentSession < ActiveRecord::Base
  belongs_to :user
  has_many :trials
  has_many :stimuli, through: :trials

  validates_acceptance_of :consent_given, accept: true, allow_nil: false
  validates_format_of :mechanical_turk_id, with: /\A[A-Za-z0-9]+\z/, on: :update

  scope :created_between, -> (start_date, end_date) {
    where(
      'created_at between ? and ?',
      start_date.to_time.beginning_of_day,
      end_date.to_time.end_of_day
    )
  }

end
