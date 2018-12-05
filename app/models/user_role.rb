class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :module_type

    after_commit :create_role_user, on: :create

    def create_role_user
    	role_user = RoleUser.where("user_id": self.user_id,"role_id": self.role_id)
	 	if role_user.present?
	 		true
	 	else
	 		role_user = RoleUser.new("user_id": self.user_id,
	 									"role_id": self.role_id)
	 		role_user.save!
	 		true
	 	end
    end
  
end
