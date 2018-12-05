module V1
	 class ResourcesController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create,:show_all,:startup_edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			# binding.pry
			check_valid_auth = check_auth
			if check_valid_auth
				resource = Resource.new(resource_params)
				resource.startup_profile_id = startup_profile.id
				startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
				if resource.save!
					render json: resource ,status: :created
				else
					# render json: {:errors => activity_response.errors}
					render json: resource.errors, status: :unprocessable_entity 
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

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

	 end
end

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