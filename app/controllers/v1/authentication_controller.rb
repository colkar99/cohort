# app/controllers/authentication_controller.rb
module V1
	class AuthenticationController < ApplicationController
	 skip_before_action :authenticate_request
	 # skip_before_action :authenticate_request, only: [:authenticate,:show_all,:startup_edit,:delete]


	 def authenticate
	 	command = AuthenticateUser.call(params[:email], params[:password],'email_login')
	   @user = User.find_by_email(params[:email])
	   if command.success?
	   	if @user.user_type == "site"
	   		UserMailer.login(@user).deliver_later
	   		render json: { auth_token: command.result,
	   					 user_type: @user.user_type,
	   					 user_id: @user.id,
	   					 roles: @user.roles }
	   	elsif @user.user_type == "startup"
	   		UserMailer.login(@user).deliver_later
	   		startup_user = StartupUser.find_by_user_id(@user.id)
	   		render json: { auth_token: command.result,
	   						 user_type: @user.user_type,
	   						 user_id: @user.id,
	   						 startup_profile_id: startup_user.startup_profile_id }
	   	elsif @user.user_type == "mentor"
	   		UserMailer.login(@user).deliver_later
	   		mentor_user = MentorUser.find_by_user_id(@user.id)
	   		render json: { auth_token: command.result,
	   						 user_type: @user.user_type,
	   						 user_id: @user.id}					 
	   	end
	   		@user.access_token = command.result
	     	@user.save!
	   else
	     render json: { message: command.errors[:message][0] }, status: :unauthorized
	   end
	 end

	 def google_login
	 	command = AuthenticateUser.call(params[:email], '123456',params[:type])
	   @user = User.find_by_email(params[:email])
	   if command.success?
	   	if @user.user_type == "site"
	   		UserMailer.login(@user).deliver_later
	   		render json: { auth_token: command.result,
	   					 user_type: @user.user_type,
	   					 user_id: @user.id,
	   					 roles: @user.roles }
	   	elsif @user.user_type == "startup"
	   		UserMailer.login(@user).deliver_later
	   		startup_user = StartupUser.find_by_user_id(@user.id)
	   		render json: { auth_token: command.result,
	   						 user_type: @user.user_type,
	   						 user_id: @user.id,
	   						 startup_profile_id: startup_user.startup_profile_id }
	   	elsif @user.user_type == "mentor"
	   		UserMailer.login(@user).deliver_later
	   		mentor_user = MentorUser.find_by_user_id(@user.id)
	   		render json: { auth_token: command.result,
	   						 user_type: @user.user_type,
	   						 user_id: @user.id}					 
	   	end
	   		@user.access_token = command.result
	     	@user.save!
	   else
	     render json: { message: command.errors[:message][0] }, status: :unauthorized
	   end
	 end

	 def contract_quiries_to_admin
	 	startup_registration = StartupRegistration.find(params[:startup_registration_id])
	 	program = Program.find(params[:program_id])
	 	if startup_registration.present? && program.present?
	 		program_admin = User.find(program.program_admin)
	 		program_director = User.find(program.program_director)
	 		contract_manager = User.find(program.contract_manager)
	 		data = {subject: params[:subject],description: params[:description]}
	 		UserMailer.send_queries_to_admin(program_admin,program_director,contract_manager,data,startup_registration).deliver_later
	 		render json: {message: "Email successfully send"},status: :ok
	 	else
	 		render json: {error: "startup or program not found with this ID"}
	 	end
	 end

	 private
	 	def return_user(user)
	    	user = {"first_name": user.first_name,
	    				"last_name": user.last_name,
	    				"phone_number": user.phone_number,
	    				"email": user.email,
	    				"user_type": user.user_type
	    			}
	    	user			
	    end
	end
end
