class Trial < ActiveRecord::Base
  belongs_to :experiment_session
  belongs_to :stimulus

  validates :response, numericality: { only_integer: true }
end
