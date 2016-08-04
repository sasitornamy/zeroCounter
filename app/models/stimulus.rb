class Stimulus < ActiveRecord::Base
  has_many :trials
  has_many :sessions, through: :trials

  scope :random, -> { order('RANDOM()') }
  scope :excluded_id, -> (ids) { where.not(id: ids) }
end
