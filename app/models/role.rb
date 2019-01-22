class Role < ApplicationRecord
	has_many :user_roles
	has_many :users ,through: :user_roles, :dependent => :delete_all

	has_many :role_users
	has_many :users ,through: :role_users, :dependent => :delete_all

	
end
