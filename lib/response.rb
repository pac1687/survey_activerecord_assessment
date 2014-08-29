class Response < ActiveRecord::Base
  before_save :normalize_name
  belongs_to :question
  has_many :survey_responses
  has_many :survey_takers, through: :survey_responses
  validates :name, :presence => true

private

  def normalize_name
    self.name = self.name.downcase
    self.name = self.name.capitalize
  end
end