class Response < ActiveRecord::Base
  belongs_to :question
  validates :name, :presence => true
end