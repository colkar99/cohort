class Session < ApplicationRecord
	has_many :session_attendees
	has_many :users, through: :session_attendees
end
