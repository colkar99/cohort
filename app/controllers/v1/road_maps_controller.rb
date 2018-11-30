module V1
	 class RoadMapsController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create,:show_all,:startup_edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			check_valid_auth = check_auth
			if check_valid_auth
				road_map = RoadMap.new(road_map_params)
				startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
				if road_map.save!
					render json: road_map ,status: :created
				else
					# render json: {:errors => activity_response.errors}
					render json: road_map.errors, status: :unprocessable_entity 
		                       
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
 	    def road_map_params
		    params.require(:road_map).permit(:id,
		    									:goal,
		    									:strategy,
		    									:description,
		    									:from_date,
		    									:to_date,
		    									:reviewed_by,
		    									:reviewer_feedback,
		    									:startup_profile_id,
		    									:program_id,
		    									:isActive
		    									 )
 	    end

	 end
end

###############raod_map params##########33
   # t.string "goal"
   #  t.text "strategy"
   #  t.text "description"
   #  t.datetime "from_date"
   #  t.datetime "to_date"
   #  t.integer "reviewed_by"
   #  t.text "reviewer_feedback"
   #  t.integer "program_id"
   #  t.integer "startup_profile_id"
   #  t.boolean "isActive", default: true
   #  t.boolean "isDelete", default: false
   #  t.integer "deleted_by"
   #  t.datetime "deleted_at"
   #  t.datetime "created_at", null: false
   #  t.datetime "updated_at", null: false
   #  t.index ["program_id"], name: "index_road_maps_on_program_id"
   #  t.index ["startup_profile_id"], name: "index_road_maps_on_startup_profile_id"