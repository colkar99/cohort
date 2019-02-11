module V1
	 class ResourcesController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create,:show_all,:startup_edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module

		def create
			# binding.pry
			resource = Resource.new(resource_params)
			startup_profile = StartupProfile.find(params[:resource][:startup_profile_id])
			program = startup_profile.startup_registration.program
			program_director = User.find(program.program_director)
			# resource.startup_profile_id = startup_profile.id
			# resource.road_map_id = params[:road_map_id]
			# resource.milestone_id = params[:milestone_id]
			if resource.save!
				UserMailer.resource_request_to_admin(startup_profile,program,program_director,resource).deliver_later
				milestone_resource_link = MilestoneResourceLink.new
				milestone_resource_link.milestone_id = params[:milestone_id] 
				milestone_resource_link.resource_id = resource.id 
				milestone_resource_link.road_map_id = resource.road_map_id
				if milestone_resource_link.save!
					render json: resource,status: :ok
				else
					render json: milestone_resource_link.errors,status: :unprocessable_entity
				end
			else
				# render json: {:errors => activity_response.errors}
				render json: resource.errors, status: :unprocessable_entity 
	                       
			end
		
		end
		def show_all
			road_maps = StartupProfile.find(params[:startup_profile_id]).road_maps
			render json: road_maps ,status: :ok
		end

		def startup_edit
			# binding.pry
			check_valid_auth = check_auth
			if check_valid_auth
				road_map = RoadMap.find(params[:road_map][:id])
				startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
				if road_map.update!(road_map_params)
					render json: road_map ,status: :ok
				else
					# render json: {:errors => activity_response.errors}
					render json: road_map.errors, status: :unprocessable_entity 
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end
			
		end

		def admin_edit
			module_grand_access = permission_control("road_map","update")
			if module_grand_access
				road_map = RoadMap.find(params[:road_map][:id])
				road_map.reviewed_by = current_user.id
				startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
				if road_map.update!(road_map_params)
					render json: road_map ,status: :ok
				else
					# render json: {:errors => activity_response.errors}
					render json: road_map.errors, status: :unprocessable_entity 
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end
			
		end


		def check_auth
 	    	auth = request.headers[:Authorization]
 	    	startup_profile = StartupProfile.find_by_password_digest(auth)
 	    	return false if !startup_profile.present?
 	    	true
 	    end


 	    private
 	    def resource_params
		    params.require(:resource).permit(:id,
		    									:resource_type,
		    									:no_of_resource,
		    									:hours_needed,
		    									:date_needed,
		    									:payment_mode,
		    									:road_map_id,
		    									:isActive,
		    									:startup_profile_id
		    									 )
 	    end
 	    def milestone_resource_link
 	    	params.require(:milestone_resource_link).permit(:id,:milestone_id,:resource_id,:road_map_id)
 	    end

	 end
end


    # t.integer "milestone_id"
    # t.integer "resource_id"
    # t.integer "road_map_id"
###############resource params##########33
# t.string "resource_type"
# t.string "no_of_resource"
# t.string "hours_needed"
# t.datetime "date_needed"
# t.string "payment_mode"
# t.integer "road_map_id"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.integer "startup_profile_id"
# t.index ["road_map_id"], name: "index_resources_on_road_map_id"
    # t.index ["startup_profile_id"], name: "index_resources_on_startup_profile_id"