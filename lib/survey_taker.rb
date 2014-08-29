class SurveyTaker< ActiveRecord::Base
  has_many :survey_responses
  has_many :responses, through: :survey_responses
  validates :name, :presence => true
end