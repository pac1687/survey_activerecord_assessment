require "spec_helper"

describe Survey do
  it { should validate_presence_of :name }
  it { should have_many :questions }
  it { should have_many :survey_responses }
end