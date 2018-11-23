class Activity < ApplicationRecord
  belongs_to :framework
  # belongs_to :checklist
  has_many :checklists
  has_many :activity_responses

end
