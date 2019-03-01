class Checklist < ApplicationRecord
  # belongs_to :framework 
  belongs_to :course 
  has_many :checklist_responses 
  	attr_accessor :admin_responsed,:admin_feedback,:mentor_feedback,:mentor_responsed,:is_passed
end
