class UserRole < ApplicationRecord
  belongs_to :user ,:dependent => :delete
  belongs_to :role_permission
end
