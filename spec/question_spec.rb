require "spec_helper"

describe Question do
  it { should validate_presence_of :name }
  it { should belong_to :survey }
  it { should have_many :responses }
  it { should have_many :survey_responses }
end