class ChecklistResponse < ApplicationRecord
  belongs_to :activity
  belongs_to :course
end
