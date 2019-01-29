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
				activity = Activity.find(params[:activity_id])
				# frameworks = Framework.find(params[:framework_id])
				checklists = activity.checklists
				framework_activity_link = FrameworkActivityLink.where("activity_id": activity.id, "framework_id": params[:framework_id] ).first
				if checklists.destroy_all!
					if activity.destroy!
						if framework_activity_link.destroy!
							render json: {error: "Activity and checklits are deleted successfully"}, status: :ok
						else
							render json: framework_activity_link.errors, status: :unprocessable_entity
						end
					else
						render json: activity.errors, status: :unprocessable_entity
		                       
					end
				else
					render json: checklists.errors,status: :unprocessable_entity
				end
				# framework.created_by = current_user.id
				# activity.isActive = false
				# activity.isDelete = true
				# activity.deleted_at = Time.now
				# activity.deleted_by = current_user.id
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

		end

		def activity_and_checklists_create
			module_grand_access = permission_control("framework","delete")
			if module_grand_access
				framework = Framework.find(params[:framework_id])
				if framework.present?
					activity = Activity.new
					activity.name = params[:activity][:name]
					activity.description = params[:activity][:description]
					activity.placeholder = params[:activity][:placeholder]
					activity.order = params[:activity][:order]
					activity.created_by = current_user.id
					if activity.save!
						puts "Activities saved successfully"
						framework_activity_link = FrameworkActivityLink.new
						framework_activity_link.framework_id = framework.id												
						framework_activity_link.activity_id = activity.id
						if framework_activity_link.save!
							params[:checklists].each do |checklist_params|
								checklist = Checklist.new
								checklist.name = checklist_params[:name]
								checklist.description = checklist_params[:description]
								checklist.framework_id = framework.id
								checklist.activity_id = activity.id
								checklist.created_by = current_user.id
								if checklist.save!
									puts "Checklists saved successfully"
								else
									render json: checklist.errors,status: :ok
								end
							end
							render json: framework,status: :ok
						else
							render json: framework_activity_link.errors, status: :unprocessable_entity
						end												
					else
						render json: activity.errors, status: :unprocessable_entity
					end	
				else
					render json: {error: "Frame work not found"}
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end

		def activity_and_checklists_update
			module_grand_access = permission_control("framework","delete")
			if module_grand_access
				framework = Framework.find(params[:framework_id])
				if framework.save!
					activity = Activity.find(params[:activity][:id])
					if activity.update!(activity_params)
						params[:checklists].each do |check_li|
							if check_li[:id].present?
								checklist = Checklist.find(check_li[:id])
								checklist.name = check_li[:name]
								checklist.description = check_li[:description]
								checklist.framework_id = framework.id
								checklist.activity_id = activity.id
								checklist.created_by = current_user.id
								if checklist.save!
									puts "Checklist successfully updated!!!!!!!!!!"
								else
									render json: checklist.errors, status: :unprocessable_entity
								end
							else
								checklist = Checklist.new
								checklist.name = check_li[:name]
								checklist.description = check_li[:description]
								checklist.framework_id = framework.id
								checklist.activity_id = activity.id
								checklist.created_by = current_user.id
								if checklist.save!
									puts "Checklists saved successfully"
								else
									render json: checklist.errors,status: :ok
								end
							end
						end
						render json: framework, status: :ok
					else
						render json: activity.errors, status: :unprocessable_entity
					end
				else
					render json: {error: "Framework not found"}, status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized					
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
	