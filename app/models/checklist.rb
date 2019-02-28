class Checklist < ApplicationRecord
  # belongs_to :framework 
  belongs_to :course 
  has_many :checklists_responses 
end
