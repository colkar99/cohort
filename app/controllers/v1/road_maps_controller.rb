module V1
	 class RoadMapsController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create,:show_all,:startup_edit,:delete,:get_road_map_for_startup]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def get_program_for_startup
			check_valid_auth = startup_auth_check(params[:startup_profile_id],current_user)
			if check_valid_auth
				startup_profile = StartupProfile.find(params[:startup_profile_id])
				startup_application = startup_profile.startup_registration
				program = startup_application.program
				road_map = startup_profile.road_map
				if program.present?
					render json: {program: program,road_map: road_map}, status: :ok
				else
					render json: {error: "Sorry you have not registered with any program"},status: :not_found
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end
		end

		def get_road_map_for_startup
			check_valid_auth = startup_auth_check(params[:startup_profile_id],current_user)
			if check_valid_auth
				startup_profile = StartupProfile.find(params[:startup_profile_id])
				if startup_profile.present?
					road_map = RoadMap.find(params[:road_map_id])
					render json: road_map,status: :ok
				else
					render json: {error: "startup_profile not found with this ID"},status: :not_found
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized				
			end
		end

		def get_road_map_for_startup_admin
	     	 module_access_grands = permission_control("road_map","show")
			if module_access_grands
				startup_profile = StartupProfile.find(params[:startup_profile_id])
				if startup_profile.present?
					road_map = RoadMap.find(params[:road_map_id])
					render json: road_map,status: :ok
				else
					render json: {error: "startup_profile not found with this ID"},status: :not_found
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized				
			end
		end

		def create
			check_valid_auth = startup_auth_check(params[:startup_profile_id],current_user)
			if check_valid_auth
				startup_profile = StartupProfile.find(params[:startup_profile_id])
				RoadMap.transaction do
					if params[:road_map][:id].present?
						road_map = RoadMap.find(params[:road_map][:id])
						if road_map.present?
							if road_map.update!(road_map_params)
								params[:milestones].each do |milestone|
									if milestone[:id].present?
										milestone_update = Milestone.find(milestone[:id])
										milestone_update.name = milestone[:name]
										milestone_update.description = milestone[:description]
										milestone_update.metric = milestone[:metric]
										milestone_update.month = milestone[:month]
										milestone_update.road_map_id = road_map.id
										if milestone_update.save!
											puts "Milestone successfully updated"
										else
											raise ActiveRecord::Rollback
											render json: milestone_update.errors, status: :unprocessable_entity
										end
									else
										milestone_create = Milestone.new
										milestone_create.name = milestone[:name]
										milestone_create.description = milestone[:description]
										milestone_create.metric = milestone[:metric]
										milestone_create.month = milestone[:month]
										milestone_create.road_map_id = road_map.id
										if milestone_create.save!
											puts "Mile stone created successfully"
										else
											raise ActiveRecord::Rollback
											render json: milestone_create.errors, status: :unprocessable_entity
										end
									end
								end
								render json: road_map,status: :ok								
							else
								render json: road_map.errors,status: :unprocessable_entity
							end
						else
							render json: {error: "Roadmap not found with this id"}
						end
					else
						road_map = RoadMap.new(road_map_params)
						program_status = ProgramStatus.find_by_status("RMD")
						startup_application = startup_profile.startup_registration
						startup_application.application_status = program_status.status
						startup_application.app_status_description = program_status.description
						startup_application.program_status_id = program_status.id
						if road_map.save! && startup_application.save!
							params[:milestones].each do |milestone|
								if milestone[:id].present?
									milestone_update = Milestone.find(milestone[:id])
									milestone_update.name = milestone[:name]
									milestone_update.description = milestone[:description]
									milestone_update.metric = milestone[:metric]
									milestone_update.month = milestone[:month]
									milestone_update.road_map_id = road_map.id
									if milestone_update.save!
										puts "Milestone successfully updated"
									else
										raise ActiveRecord::Rollback
										render json: milestone_update.errors, status: :unprocessable_entity
									end
								else
									milestone_create = Milestone.new
									milestone_create.name = milestone[:name]
									milestone_create.description = milestone[:description]
									milestone_create.metric = milestone[:metric]
									milestone_create.month = milestone[:month]
									milestone_create.road_map_id = road_map.id
									if milestone_create.save!
										puts "Mile stone created successfully"
									else
										raise ActiveRecord::Rollback
										render json: milestone_create.errors, status: :unprocessable_entity
									end
								end
							end
							render json: road_map,status: :created
						else
							# render json: {:errors => activity_response.errors}
							render json: road_map.errors, status: :unprocessable_entity                
						end
					end
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end
		end

		def delete
			check_valid_auth = startup_auth_check(params[:startup_profile_id],current_user)
			if check_valid_auth
				road_map = RoadMap.find(params[:road_map][:id])
				if road_map.present?
					RoadMap.transaction do
						milestones = road_map.milestones
						milestones.each do |milestone|
							if milestone.destroy
								puts "milestone destroyed successfully"
							else
								render json: milestone.errors,status: :unprocessable_entity
							end 
						end
						if road_map.destroy
							render json: road_map, status: :ok
						else
							render json: road_map.errors,status: :unprocessable_entity
						end 
					end
				else
					render json: {error: "Road map not present with this ID"}, status: :unprocessable_entity 
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

###############mile stone params##########
    # t.string "name"
    # t.text "description"
    # t.text "metric"
    # t.integer "road_map_id"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.index ["road_map_id"], name: "index_milestones_on_road_map_id"
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