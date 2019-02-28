class Checklist < ApplicationRecord
  # belongs_to :framework 
  belongs_to :course 
  has_many :checklist_responses 
end
