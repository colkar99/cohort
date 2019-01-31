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
				render json: {error: "You dont have access to perform this action,Please contact Site admin"}, status: :unauthorized
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
				framework = Framework.find(params[:framework][:id])
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
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized
			end

			
		end

		

		def delete
			module_grand_access = permission_control("framework","delete")
			if module_grand_access
				framework = Framework.find(params[:framework][:id])
				# framework.created_by = current_user.id
				# framework.isActive = false
				# framework.isDelete = true
				# framework.deleted_at = Time.now
				# framework.deleted_by = current_user.id
				if framework.destroy
					render json: framework ,status: :ok
				else
					render json: framework, status: :unprocessable_entity
		                       
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized
			end

		end

		def assign_courses_to_framework
			module_grand_access = permission_control("framework","update")
			if module_grand_access
				framework = Framework.find(params[:framework_id])
				if framework.present?
					params[:course_ids].each do |id|
						course_val = Course.find(id)
						if course_val.present?
							framework_course_link = FrameworkCourseLink.new
							framework_course_link.framework_id = framework.id
							framework_course_link.course_id = course_val.id
							if framework_course_link.save!
								puts "Framework Course link saved"
							else
								render json: framework_course_link.errors,status: :bad_request
							end
						else
							render json: {error: "Some courses ids not present"}
						end
					end
					render json: framework , status: :ok
				else
					render json: {error: "Framework not found with this id"}, status: :not_found
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end

		def remove_activities_from_framework
			module_grand_access = permission_control("framework","delete")
			if module_grand_access
				framework = Framework.find(params[:framework_id])
				if framework.present?
					params[:activity_ids].each do |id|
						framework_activity_link = FrameworkActivityLink.where(framework_id: framework,activity_id: id).first
						if framework_activity_link.destroy!
							puts "Activity successfully removed from the framework"
						else
							render json: framework_activity_link.errors, status: :unprocessable_entity
						end
					end
					render json: {message: "Activities are successfully merged with framework"}, status: :ok
				else
					render json: {error: "Framework not found "}, status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized				
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


#####Activity############
# t.string "name"
# t.text "description"
# t.text "placeholder"
# t.integer "order"

####### checklist##########

   # t.string "name"
   #  t.text "description"
   #  t.integer "framework_id"
   #  t.integer "activity_id"
   #  t.integer "created_by"