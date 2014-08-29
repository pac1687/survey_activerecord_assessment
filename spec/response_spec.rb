require "spec_helper"

describe Response do
  it { should validate_presence_of :name }
  it { should belong_to :question }
  it { should have_many :survey_takers }
  it { should have_many :survey_responses }

  it 'normalizes the response by capitalizing the first letter and making the rest lower case' do
    response = Response.create(:name => "BLUE")
    response.name.should eq "Blue"
  end
end