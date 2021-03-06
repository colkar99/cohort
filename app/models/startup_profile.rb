class StartupProfile < ApplicationRecord
	belongs_to :startup_registration	
  	has_many :programs ,through: :startup_registrations
  	has_many :activity_responses
  	has_one :road_map
  	has_many :selected_mentors
	has_many :users, through: :selected_mentors
	has_many :startup_users
	has_many :users, through: :startup_users
	has_many :founding_sources
	has_many :courses, through: :activity_responses
	# has_one :program_status ,through: :startup_registrations
	 mount_base64_uploader :main_image, PictureUploader
	 has_many :news_feed_comments
	 has_many :news_feeds


	# has_many :current_state_forms


end
