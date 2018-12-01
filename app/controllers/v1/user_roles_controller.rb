# app/controllers/authentication_controller.rb
module V1
	class UserRolesController < ApplicationController
		# before_action  :current_user, :get_module
	 # skip_before_action :authenticate_request
	 def create
	 	user_roles_permission = permission_control("user_role","create")
	 	role_permission =  permission_control("role","create")
	 	if user_roles_permission && role_permission
	 		user_role = UserRole.new(user_role_params)
	 		user_role.created_by = current_user.id
	 		if user_role.save!
	 			render json: @user_role ,status: :created 

	 		else
	 			render json: user.errors, status: :unprocessable_entity
	 		end
	 	else
	 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
	 	end
	 end

	 def index
	 	# module_grand_access = user_validate("create")
	 	module_grand_access = permission_control("user_role","create")
	 	if module_grand_access
	 		users = User.select("id,first_name,last_name,phone_number,user_main_image,access_token,created_at,created_at").all
	 		roles = Role.all
	 		module_types = ModuleType.all
	 		user_roles = UserRole.all
	 		render json: {user_roles: user_roles, users: users,roles: roles,modules: module_types}, status: :ok
	 	else
	 		render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

	 	end
	 	
	 end

	 def edit
	 	# binding.pry
	 	# module_grand_access = user_validate("update")
	 	module_grand_access = permission_control("user_role","update")
	 	if module_grand_access
		 	@user_role = UserRole.find(params[:user_role][:id])
		 	if @user_role.update(user_role_params)
		 		render json: @user_role ,status: :ok 
		 	else
		 		render json: @user_role, status: :unprocessable_entity
		 	end
		else
			render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

		end 	
	 end

	 def delete
	 	# binding.pry
	 	# module_grand_access = user_validate("delete")
	 	module_grand_access = permission_control("user_role","delete")
	 	if module_grand_access
		 	@user_role = UserRole.find(params[:user_role][:id])
		 	@user_role.deleted_by = current_user.id
		 	@user_role.isDelete = true
		 	if @user_role.update(user_role_params)
		 		render json: @user_role ,status: :ok 
		 	else
		 		render json: @user_role, status: :unprocessable_entity
		 	end
		else
			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

		end 	
	 end

	 def grant_access
	 	user_roles = []
	 	modules = ModuleType.all
	 	modules.each do |module_type|
	 		binding.pry
	 		user_role = UserRole.new(user_role_params)
	 		user_role.module_type_id = module_type.id
	 		user_role.create_rule = true
	 		user_role.update_rule = true
	 		user_role.show_rule = true
	 		user_role.delete_rule = true
	 		user_role.created_by = current_user.id
	 		binding.pry
	 		if user_role.save!
	 			user_roles.push(user_role)
	 		end
	 	end
	 	render json: user_roles, status: :ok 
	 end

	 private

	 def user_role_params
	 	params.require(:user_role).permit(:user_id,:role_id,:module_type_id,:create_rule,:update_rule,:delete_rule,:isDelete,
	 										:created_by,:deleted_by,:show_rule)
	 end
	end
end
