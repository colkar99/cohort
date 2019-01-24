module V1
	 class ActivitiesController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			# binding.pry
			module_grand_access = permission_control("activity","create")
			if module_grand_access
				activity = Activity.new(activity_params)
				activity.created_by = current_user.id
				if activity.save!
					render json: activity ,status: :created
				else
					render json: activity, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end
		end

		def show_all
			module_grand_access = permission_control("activity","show")
			if module_grand_access
				activities = Activity.all
				render json: activities, status: :ok
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end

			
		end

		def show
			module_grand_access = permission_control("activity","show")
			if module_grand_access
				activities = Framework.find(params[:framework_id]).activities
				render json: activities, status: :ok
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized
			end
		end

		def edit
			module_grand_access = permission_control("activity","update")
			if module_grand_access
				activity = Activity.find(params[:activity][:id])
				# framework.created_by = current_user.id
				if activity.update!(activity_params)
					render json: activity ,status: :ok
				else
					render json: activity, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

			
		end

		

		def delete
			module_grand_access = permission_control("activity","delete")
			if module_grand_access
				activity = Activity.find(params[:activity][:id])
				# framework.created_by = current_user.id
				activity.isActive = false
				activity.isDelete = true
				activity.deleted_at = Time.now
				activity.deleted_by = current_user.id
				if activity.update!(activity_params)
					render json: activity ,status: :ok
				else
					render json: activity, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

		end



 	    private
 	    def activity_params
		    params.require(:activity).permit(:id,
		    									:name,
		    									:description,
		    									:placeholder,
		    									:order,
		    									:framework_id,
		    									:created_by,
		    									:isActive,
		    									:deleted_by
		    									 )
 	    end

	 end
end


######activity params########

# t.string "name"
#     t.text "description"
#     t.text "placeholder"
#     t.integer "order"
#     t.integer "framework_id"
#     t.integer "created_by"
#     t.boolean "isActive", default: true
#     t.boolean "isDelete", default: false
#     t.integer "deleted_by"
#     t.datetime "deleted_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["framework_id"], name: "index_activities_on_framework_id"
	