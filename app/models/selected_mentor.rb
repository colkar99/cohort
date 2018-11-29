class SelectedMentor < ApplicationRecord
	belongs_to :user
	belongs_to :startup_profile
end
