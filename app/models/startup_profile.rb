class StartupProfile < ApplicationRecord
	has_secure_password
	has_many :startup_registrations	
  	has_many :programs ,through: :startup_registrations
  	has_many :activity_responses
  	has_many :road_maps
  	has_many :selected_mentors
	has_many :users, through: :selected_mentors
	has_many :startup_users
	has_many :users, through: :startup_users


end
