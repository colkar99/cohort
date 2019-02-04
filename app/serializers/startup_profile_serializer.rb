class StartupProfileSerializer < ActiveModel::Serializer
  attributes :id ,:startup_name,:email,:main_image,:thumb_image,:logo_image,:founded_date,:description,:incorporated,
  				:team_size,:current_stage,:logged_in_first_time, :address_line_1,:address_line_2,:city,:state_province_region,:zip_pincode_postalcode,:country,:geo_location
  has_many :users
  has_many :founding_sources
  belongs_to :startup_registration			 
end
