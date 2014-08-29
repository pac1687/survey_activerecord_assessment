require "spec_helper"

describe Response do
  it { should validate_presence_of :name }
  it { should belong_to :question }
  it { should have_many :survey_takers }
  it { should have_many :survey_responses }
end