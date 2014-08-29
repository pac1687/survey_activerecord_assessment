class Survey < ActiveRecord::Base
  has_many :questions
  has_many :survey_responses
  validates :name, :presence => true
end