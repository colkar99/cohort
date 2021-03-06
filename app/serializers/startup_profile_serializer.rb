class StartupProfileSerializer < ActiveModel::Serializer
  attributes :id ,:startup_name,:email,:main_image,:thumb_image,:logo_image,:founded_date,:description,:incorporated,:current_status,:facebook_link,:linkedin_link,:skype_id,:other_links,
  				:team_size,:current_stage,:logged_in_first_time, :address_line_1,:address_line_2,:city,:state_province_region,:zip_pincode_postalcode,:country,:geo_location,:twitter_url,:youtube_url,
          :instagram_url,:pinterest_url
  has_many :users
  has_many :founding_sources
  belongs_to :startup_registration
  has_one :road_map
  # has_one :program_status ,through: :startup_registrations
  def current_status
  	object.startup_registration.program_status
  end
			 
end
