class Activity < ApplicationRecord
  has_many :course_activity_links
  has_many :courses, through: :course_activity_links ,:dependent => :delete_all 
  # belongs_to :checklist
  has_many :checklists 
  has_many :activity_responses
end
