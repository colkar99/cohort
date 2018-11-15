class User < ApplicationRecord
	has_secure_password
	has_many :user_roles ,:dependent => :delete_all
	has_many :role_permissions ,through: :user_roles,:dependent => :delete_all
	has_many :roles ,through: :role_permissions,:dependent => :delete_all

	before_save  :set_create_attr

	
	def set_create_attr
		self.full_name = self.first_name + " " + self.last_name
	end
	
end
