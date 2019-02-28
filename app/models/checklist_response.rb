class ChecklistResponse < ApplicationRecord
  belongs_to :checklist
  belongs_to :course
end
