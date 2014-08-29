require "spec_helper"

describe SurveyResponse do
  it { should validate_presence_of :survey_taker_id }
  it { should validate_presence_of :survey_id }
  it { should validate_presence_of :question_id }
  it { should validate_presence_of :response_id }
  it { should belong_to :survey_taker }
  it { should belong_to :survey }
  it { should belong_to :question }
  it { should belong_to :response }
end