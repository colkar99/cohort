# app/controllers/authentication_controller.rb
module V1
	class RolesController < ApplicationController
	
		def create
			module_grant_access = permission_control("role","create")
			if module_grant_access
				role = Role.new(role_params)
				role.created_by = current_user.id
				if role.save!
					render json: role, status: :created
				else
					render json: role.errors , status: :unprocessable_entity
				end
			else
	 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end

		end

		def get_role_by_user_type
			module_grant_access = permission_control("role","show")
			if module_grant_access
				roles = Role.where(user_role_type: params[:user_role_type])
				render json: roles, status: :ok
			else
	 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end

		def show_all
			module_grant_access = permission_control("role","show")
			if module_grant_access
				roles = Role.all
				render json: roles, status: :ok
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
			end
		end

		def edit
			module_grant_access = permission_control("role","update")
			if module_grant_access
				role = Role.find(params[:role][:id])
				# role.created_by = current_user.id
				if role.update!(role_params)
					render json: role, status: :ok
				else
					render json: role.errors , status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
			end
		end

		def delete
			module_grant_access = permission_control("role","delete")
			if module_grant_access
				role = Role.find(params[:role][:id])
				role.isDelete = true
				role.isActive = false
				role.deleted_by = current_user.id
				role.deleted_at = Time.now
				# role.created_by = current_user.id
				if role.update!(role_params)
					render json: role, status: :ok
				else
					render json: role.errors , status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
			end
		end
	 private

	 def role_params
	 	params.require(:role).permit(:name,:description,:isActive,:isDelete)
	 end
	end
end

#######Roles params
# t.string "name"
# t.text "description"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "created_by"
# t.integer "deleted_by"
# t.datetime "deleted_at"