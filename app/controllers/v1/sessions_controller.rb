module V1
	 class SessionsController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:show_sessions_to_startups]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
	 	def create
	 		module_grand_access = permission_control("session","create")
	 		if module_grand_access
	 			session = Session.new(session_params)
	 			session.created_by = current_user.id
	 			if session.save!
	 				render json: session, status: :created
	 			else
	 				render json: session.errors,status: :bad_request
	 			end
	 		else
 	  			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 			
			end
	 	end

	 	def edit
	 		module_grand_access = permission_control("session","update")
	 		if module_grand_access
	 			session = Session.find(params[:session][:id])
	 			if session.present?
		 			session.created_by = current_user.id
		 			if session.update!(session_params)
		 				render json: session, status: :ok
		 			else
		 				render json: session.errors,status: :bad_request
		 			end
	 			else
	 				render json: {errro: "Session not available with this id"}
	 			end
	 		else
 	  			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 			
			end
	 	end

	 	def delete
	 		module_grand_access = permission_control("session","update")
	 		if module_grand_access
	 			session = Session.find(params[:session][:id])
	 			if session.present?
	 				session_attendees = session.session_attendees
	 				if session_attendees.present?
	 					if session_attendee.destroy_all
		 					if session.destroy
		 						render json: session, status: :ok
		 					else
		 						render json: session.errors,status: :bad_request
		 					end	 						
	 					else
	 						render json: session_attendees.errors,status: :bad_request
	 					end
	 				else
	 					if session.destroy
	 						render json: session, status: :ok
	 					else
	 						render json: session.errors,status: :bad_request
	 					end
	 				end
	 			else
	 				render json: "Session with this id is nor present", status: :bad_request
	 			end
	 		else
 	  			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 				 			
	 		end
	 	end

	 	def program_session_show
	 		module_grand_access = permission_control("session","show")
	 		if module_grand_access
	 			program = Program.find(params[:program_id])
	 			if program.present?
	 				sessions = program.sessions
	 				if sessions.present?
	 					render json: sessions, status: :ok
	 				else
	 					render json: {error: "sessions are not available for this program"}
	 				end
	 			else
	 				render json: {error: "Program not found with this id"}, status: :bad_request
	 			end
 			else
 	  			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 				 			 				
 			end
	 	end

	 	def show_session_attendees
	 		module_grand_access = permission_control("session","show")
			if module_grand_access
				session = Session.find(params[:session][:id])
				if session.present?
					session_users = []
					session_attendees = session.session_attendees
					session_attendees.each do |attendee|
						user = attendee.user
						session_users.push(user)
					end
					render json: session_users, status: :ok
				else
					render json: {error: "session are not present with this id"},status: :bad_request
				end
			else
 	  			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 				 			 								
			end	 		
	 	end

	 	def get_program_related_users
	 		mentors = User.where(user_type: 'mentor')
	 		program = Program.find(params[:program_id])
	 		site_users = []
	 		startup_users = []
	 		# binding.pry
	 		# site_admin = User.find(program.site_admin)
	 		program_admin = User.find(program.program_admin)
	 		program_director = User.find(program.program_director)
	 		application_manager = User.find(program.application_manager)
	 		contract_manager = User.find(program.contract_manager)
	 		startup_profiles = program.startup_profiles
	 		startup_profiles.each do |startup_profile|
	 			startup_name = startup_profile.startup_name
	 			this_startup_user = startup_profile.users.first
	 			startup_users.push({startup_name: startup_name,startup_users: this_startup_user })
	 		end
	 		site_users = { program_admin: program_admin,program_director: program_director,application_manager: application_manager,contract_manager: contract_manager}
	 		render json: {mentors: mentors,site_users: site_users,startup_users: startup_users}, status: :ok
	 	end

	 	def assign_attendees_to_session
	 		module_grand_access = permission_control("session","update")
	 		if module_grand_access
	 			SessionAttendee.transaction do
		 			session = Session.find(params[:session][:id])
		 			if session.present?
		 				mentors = params[:mentors]
		 				binding.pry
		 				mentors.each do |mentor|
		 					user = User.find(mentor)
		 					if user.present?
			 					attendee = SessionAttendee.new
			 					attendee.session_id = session.id
			 					attendee.user_id = user.id
			 					attendee.role = user.user_type
			 					# attendee.role = user.user_type
			 					if attendee.save!
			 						puts "Mentors added to sessions"
			 					else
			 						raise ActiveRecord::Rollback
			 						render json: attendee.errors,status: :bad_request
			 					end
		 					else
	      						raise ActiveRecord::Rollback		 						
		 						render json: {error: "Oops something happend"},status: :bad_request
		 					end
		 				end
		 				startup_users = params[:startups]
		 				startup_users.each do |startup_user|
		 					user = User.find(startup_user)
		 					if user.present?
		 						startup_profile = user.startup_profiles.first
		 						if startup_profile.present?
		 							attendee = SessionAttendee.new
				 					attendee.session_id = session.id
				 					attendee.user_id = user.id
				 					attendee.role = user.user_type
				 					attendee.startup_profile_id = startup_profile.id
				 					if attendee.save!
				 						puts "startups added to sessions"
				 					else
	      								raise ActiveRecord::Rollback				 						
				 						render json: attendee.errors,status: :bad_request
				 					end
		 						else
	      							raise ActiveRecord::Rollback		 							
		 							render json: {error: "Something happened Please contact admin"},status: :bad_request
								end
		 					else
		 						raise ActiveRecord::Rollback
		 						render json: {error: "some thing happened"},status: :bad_request
		 					end
		 				end
		 				site_users = params[:site_users]
		 				site_users.each do |site_user|
		 					user = User.find(site_user)
		 					if user.present?
			 					attendee = SessionAttendee.new
			 					attendee.session_id = session.id
			 					attendee.user_id = user.id
			 					attendee.role = user.user_type
			 					# attendee.role = user.user_type
			 					if attendee.save!
			 						puts "Mentors added to sessions"
			 					else
			 						raise ActiveRecord::Rollback
			 						render json: attendee.errors,status: :bad_request
			 					end
		 					else
	      						raise ActiveRecord::Rollback		 						
		 						render json: {error: "Oops something happend"},status: :bad_request
		 					end
		 				end
		 				render json: {message: "attendees added successfully"},status: :ok
		 			else
		 				raise ActiveRecord::Rollback
		 				render json: {error: "session with this ID not present"}, status: :bad_request
		 			end
	 			end
	 		else
	 			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	
	 		end
	 	end

	 	def show_sessions_to_startups
 	    	startup_auth = startup_auth_check(params[:startup_profile_id],current_user)
 	    	if startup_auth
 	    		program = Program.find(params[:program_id])
 	    		if program.present?
 	    			sessions = program.sessions
 	    			render json: sessions,status: :ok
 	    		else
 	    			render json: {error: "Program not found with this id"},status: :bad_request
 	    		end
 	    	else
 	    		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
 	    	end
	 	end

 	    private
 	    def session_params
		    params.require(:session).permit(:id,
		    									:title,
		    									:description,
		    									:start_date_time,
		    									:end_date_time,
		    									:where,
		    									:created_by,
		    									:isActive,
		    									:program_id
		    									 )
 	    end
 	    def session_attendee_params
		    params.require(:session).permit(:id,
		    									:session_id,
		    									:user_id,
		    									:role,
		    									:attendence_confirmation,
		    									:startup_profile_id,
		    									:created_by,
		    									:isActive,
		    									 )
 	    end

	 end
end


######Session_attendees########
# t.integer "session_id"
# t.integer "user_id"
# t.string "role"
# t.boolean "attendence_confirmation", default: true
# t.integer "startup_profile_id"
# t.boolean "isActive", default: true
# t.integer "created_by"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["session_id"], name: "index_session_attendees_on_session_id"
# t.index ["startup_profile_id"], name: "index_session_attendees_on_startup_profile_id"
# t.index ["user_id"], name: "index_session_attendees_on_user_id"
  
  #@#############Session
# t.text "title"
# t.text "description"
# t.datetime "start_date_time"
# t.datetime "end_date_time"
# t.text "where"
# t.integer "program_id"
# t.boolean "isActive", default: true
# t.integer "created_by"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["program_id"], name: "index_sessions_on_program_id"
	