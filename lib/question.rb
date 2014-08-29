class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
  has_many :survey_responses
  validates :name, :presence => true
end