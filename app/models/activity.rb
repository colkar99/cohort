class Activity < ApplicationRecord
  has_many :framework_activity_links,:dependent => :delete_all 
  has_many :frameworks, through: :framework_activity_links ,:dependent => :delete_all 
  # belongs_to :checklist
  has_many :checklists 
  has_many :activity_responses
end
