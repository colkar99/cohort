module V1
	 class RoleUsersController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
	 	def delete_role_user_by_admin
	 		module_grand_access = permission_control("role_user","delete")
	 		if module_grand_access
	 			role_user = RoleUser.where("user_id": params[:user_id],"role_id": params[:role_id]).first
	 			if role_user.present?
	 				user_roles = UserRole.where("user_id": params[:user_id],"role_id": params[:role_id],"isDelete":false)
	 				if user_roles.present?
	 					user_roles.destroy_all
	 					# user_roles.each do |user_role|
	 					# 	user_role.isDelete = true
	 					# 	user_role.save!
	 					# end
	 				end
	 				if role_user.destroy!
	 					render json: role_user,status: :ok
	 				else
	 					render json: role_user.errors , status: :ok
	 				end
	 			else
	 				render json: {warning: "This role not assigned for this user"}, status: :ok
	 			end
	 		else
	 			render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized	 			
	 		end

	 	end


 	    private
 	    def role_user_params
		    params.require(:role_user).permit(:user_id,:role_id,:isActive)
 	    end

	 end
end


######role users params########

    # t.integer "user_id"
    # t.integer "role_id"
    # t.integer "created_by"
    # t.boolean "isActive", default: true
    # t.boolean "isDelete", default: false
    # t.integer "deleted_by"
    # t.datetime "deleted_at"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.index ["role_id"], name: "index_role_users_on_role_id"
    # t.index ["user_id"], name: "index_role_users_on_user_id"