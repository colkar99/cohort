# app/controllers/authentication_controller.rb
module V1
	class AuthenticationController < ApplicationController
	 skip_before_action :authenticate_request

	 def authenticate
	   command = AuthenticateUser.call(params[:email], params[:password])
	   @user = User.find_by_email(params[:email])
	   if command.success?
	   	if @user.user_type == "site"
	   		render json: { auth_token: command.result,
	   					 user_type: @user.user_type,
	   					 user_id: @user.id }
	   	elsif @user.user_type == "startup"
	   		startup_user = StartupUser.find_by_user_id(@user.id)
	   		render json: { auth_token: command.result,
	   						 user_type: @user.user_type,
	   						 user_id: @user.id,
	   						 startup_profile_id: startup_user.startup_profile_id }
	   	elsif @user.user_type == "mentor"
	   		mentor_user = MentorUser.find_by_user_id(@user.id)
	   		render json: { auth_token: command.result,
	   						 user_type: @user.user_type,
	   						 user_id: @user.id}					 
	   	end
	   		@user.access_token = command.result
	     	@user.save!
	   else
	     render json: { error: command.errors }, status: :unauthorized
	   end
	 end

	 private
	 	def return_user(user)
	    	user = {"first_name": user.first_name,
	    				"last_name": user.last_name,
	    				"phone_number": user.phone_number,
	    				"email": user.email,
	    				"user_type": user.user_type}
	    	user			
	    end
	end
end
