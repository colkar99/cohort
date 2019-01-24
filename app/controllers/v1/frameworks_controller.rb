module V1
	 class FrameworksController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			module_grand_access = permission_control("framework","create")
			if module_grand_access
				framework = Framework.new(framework_params)
				framework.created_by = current_user.id
				if framework.save!
					render json: framework ,status: :created
				else
					render json: framework, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end
		end

		def show_all
			module_grand_access = permission_control("framework","show")
			if module_grand_access
				frameworks = Framework.all
				render json: frameworks, status: :ok
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end

		def show
			module_grand_access = permission_control("framework","show")
			if module_grand_access
				framework = Program.find(params[:framework][:id])
				render json: framework, status: :ok
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end
			
		end

		def edit
			module_grand_access = permission_control("framework","update")
			if module_grand_access
				framework = Framework.find(params[:framework][:id])
				# framework.created_by = current_user.id
				if framework.update!(framework_params)
					render json: framework ,status: :ok
				else
					render json: framework, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

			
		end

		

		def delete
			module_grand_access = permission_control("framework","delete")
			if module_grand_access
				framework = Framework.find(params[:framework][:id])
				# framework.created_by = current_user.id
				framework.isActive = false
				framework.isDelete = true
				framework.deleted_at = Time.now
				framework.deleted_by = current_user.id
				if framework.update!(framework_params)
					render json: framework ,status: :ok
				else
					render json: framework, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

		end



 	    private
 	    def framework_params
		    params.require(:framework).permit(:id,
		    									:title,
		    									:description,
		    									:activity_name,
		    									:level,
		    									:main_image,
		    									:thumb_image,
		    									:url,
		    									:created_by,
		    									:isActive
		    									 )
 	    end

	 end
end


######current_state_form params########

# t.string "title"
# t.text "description"
# t.string "activity_name"
# t.integer "level", default: 0
# t.string "main_image"
# t.string "thumb_image"
# t.string "url"
# t.integer "created_by"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

	