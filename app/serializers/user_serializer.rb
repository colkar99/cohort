class UserSerializer < ActiveModel::Serializer
  attributes :id ,:first_name,:last_name,:full_name,:email,:user_main_image,:access_token,
  :phone_number,:user_type,:roles,:is_first_time_logged_in,:startup_profile_name,:facebook_link,
  :linkedin_link,:skype_id,:other_links,:credentials,:commitment,:address_line_1,:address_line_2,:city,
  :state_province_region,:zip_pincode_postalcode,:country,:designation
  	has_one :mentor_user

  def roles
  	object.roles
  end
  def startup_profile_name
  	# object.startup_profiles.try.first.startup_name
  	object.startup_profiles.first.try(:startup_name)
  end
end

