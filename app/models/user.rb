class User < ApplicationRecord
	has_secure_password
	has_many :user_roles ,:dependent => :delete_all
	has_many :role_permissions ,through: :user_roles,:dependent => :delete_all
	has_many :roles ,through: :role_permissions,:dependent => :delete_all
end
