class ActivityResponse < ApplicationRecord
  belongs_to :framework
  belongs_to :startup_profile
  belongs_to :activity
  belongs_to :checklist
end
