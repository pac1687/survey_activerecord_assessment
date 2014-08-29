class Response < ActiveRecord::Base
  belongs_to :question
  has_many :survey_responses
  has_many :survey_takers, through: :survey_responses
  validates :name, :presence => true
end