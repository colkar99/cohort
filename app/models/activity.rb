class Activity < ApplicationRecord
  belongs_to :framework
  # belongs_to :checklist
  has_many :checklists ,dependent: :delete_all
  has_many :activity_responses

end
