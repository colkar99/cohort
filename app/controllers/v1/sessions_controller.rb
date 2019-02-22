module V1
	 class SessionsController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
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
	