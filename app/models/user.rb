class User < ApplicationRecord
	has_secure_password
	 # mount_uploader :user_main_image, PictureUploader
	 mount_base64_uploader :user_main_image, PictureUploader

	# has_many :user_roles ,:dependent => :delete_all
	# has_many :role_permissions ,through: :user_roles,:dependent => :delete_all
	# has_many :roles ,through: :role_permissions,:dependent => :delete_all
	has_many :user_roles
	has_many :roles, through: :user_roles
	has_many :selected_mentors
	has_many :startup_profiles, through: :selected_mentors
	has_many :startup_users
	has_many :startup_profiles, through: :startup_users
	# has_many :startup_profiles ,through: :selected_mentors,:dependent => :delete_all
	has_many :role_users
	has_many :roles, through: :role_users

	before_save  :set_create_attr
	before_validation :downcase_email
	validates :email, :uniqueness => { :case_sensitive => false }
	attr_accessor :role

	
	def set_create_attr
		if self.first_name && self.last_name
			self.full_name = self.first_name + " " + self.last_name
		end	
	end



	private

	def downcase_email
	  self.email = email.downcase if email.present?
	end
	
end
