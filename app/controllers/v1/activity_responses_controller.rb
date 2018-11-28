module V1
	 class ActivityResponsesController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			check_valid_auth = check_auth
			if check_valid_auth
				activity_response = ActivityResponse.new(activity_response_params)
				startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
				if activity_response.save!
					render json: activity_response ,status: :created
				else
					# render json: {:errors => activity_response.errors}
					render json: activity_response.errors, status: :unprocessable_entity 
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end
			# module_grand_access = permission_control("checklist","create")
			# if module_grand_access
			# 	checklist = Checklist.new(checklist_params)
			# 	checklist.created_by = current_user.id
			# 	if checklist.save!
			# 		render json: checklist ,status: :created
			# 	else
			# 		render json: checklist, status: :unprocessable_entity
		                       
			# 	end
			# else
			# 	render json: {error: "Invalid Authorization"}, status: :unauthorized
			# end
		end

		def rating_by_admin
			module_grand_access = permission_control("activity_response","update")
			if module_grand_access
				activity_response = ActivityResponse.find(params[:activity_response][:id])
				activity_response.admin_id = current_user.id
				if activity_response.update!(activity_response_params)
					render json: activity_response ,status: :ok

				else
					render json: activity_response.errors, status: :unprocessable_entity 

				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end

		end

		def show_all
			activity_responses = ActivityResponse.where("isDelete": false,"isActive": true,
														"program_id": params[:activity_response][:program_id] ,
														"startup_profile_id": params[:activity_response][:startup_profile_id] )
			render json: activity_responses, status: :ok
			
		end

		# def show
		# 	activities = Activity.find(params[:activity_id]).checklists.where("isDelete": false)
		# 	render json: activities, status: :ok
			
		# end

		# def edit
		# 	module_grand_access = permission_control("checklist","update")
		# 	if module_grand_access
		# 		checklist = Checklist.find(params[:checklist][:id])
		# 		# framework.created_by = current_user.id
		# 		if checklist.update!(checklist_params)
		# 			render json: checklist ,status: :ok
		# 		else
		# 			render json: checklist, status: :unprocessable_entity
		                       
		# 		end
		# 	else
		# 		render json: {error: "Invalid Authorization"}, status: :unauthorized
		# 	end

			
		# end

		

		# def delete
		# 	module_grand_access = permission_control("checklist","delete")
		# 	if module_grand_access
		# 		checklist = Checklist.find(params[:checklist][:id])
		# 		# framework.created_by = current_user.id
		# 		checklist.isActive = false
		# 		checklist.isDelete = true
		# 		checklist.deleted_at = Time.now
		# 		checklist.deleted_by = current_user.id
		# 		if checklist.update!(checklist_params)
		# 			render json: checklist ,status: :ok
		# 		else
		# 			render json: checklist, status: :unprocessable_entity
		                       
		# 		end
		# 	else
		# 		render json: {error: "Invalid Authorization"}, status: :unauthorized
		# 	end

		# end

		def check_auth
 	    	auth = request.headers[:Authorization]
 	    	startup_profile = StartupProfile.find_by_password_digest(auth)
 	    	return false if !startup_profile.present?
 	    	true
 	    end


 	    private
 	    def activity_response_params
		    params.require(:activity_response).permit(:id,
		    									:startup_response,
		    									:framework_id,
		    									:startup_profile_id,
		    									:activity_id,
		    									:checklist_id,
		    									:checklist_status,
		    									:admin_rating,
		    									:admin_feedback,
		    									:mentor_rating,
		    									:mentor_feedback,
		    									:isActive,
		    									:admin_id,
		    									:mentor_id,
		    									:program_id
		    									 )
 	    end

	 end
end
##########activity responses params############
# t.text "startup_response"
# t.integer "framework_id"
# t.integer "startup_profile_id"
# t.integer "activity_id"
# t.integer "checklist_id"
# t.boolean "checklist_status", default: false
# t.integer "admin_rating"
# t.text "admin_feedback"
# t.integer "mentor_rating"
# t.text "mentor_feedback"
# t.integer "created_by"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.integer "admin_id"
# t.integer "mentor_id"
# t.integer "program_id"
# t.index ["activity_id"], name: "index_activity_responses_on_activity_id"
# t.index ["checklist_id"], name: "index_activity_responses_on_checklist_id"
# t.index ["framework_id"], name: "index_activity_responses_on_framework_id"
# t.index ["startup_profile_id"], name: "index_activity_responses_on_startup_profile_id"
    # t.index ["program_id"], name: "index_activity_responses_on_program_id"
