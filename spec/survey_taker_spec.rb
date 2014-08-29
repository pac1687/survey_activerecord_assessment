require "spec_helper"

describe SurveyTaker do
  it { should validate_presence_of :name }
  it { should have_many :survey_responses }
  it { should have_many :responses }
end