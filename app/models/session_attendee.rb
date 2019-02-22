class SessionAttendee < ApplicationRecord
  belongs_to :session
  belongs_to :user
  # belongs_to :startup_profile
end
