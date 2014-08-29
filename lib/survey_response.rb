class SurveyResponse < ActiveRecord::Base
  belongs_to :survey_taker
  belongs_to :survey
  belongs_to :question
  belongs_to :response
  validates :survey_taker_id, :presence => true
  validates :survey_id, :presence => true
  validates :question_id, :presence => true
  validates :response_id, :presence => true
end