class Session < ActiveRecord::Base
  belongs_to :user
  has_many :trials
end
