class Activity < ApplicationRecord
  has_many :framework_activity_links
  has_many :frameworks, through: :framework_activity_links
  # belongs_to :checklist
  has_many :checklists ,dependent: :delete_all
  has_many :activity_responses

end
