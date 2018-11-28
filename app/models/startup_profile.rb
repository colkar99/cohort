class StartupProfile < ApplicationRecord
	has_secure_password
	has_many :startup_registrations	
  has_many :programs ,through: :startup_registrations
  has_many :activity_responses
  has_many :road_maps
end
