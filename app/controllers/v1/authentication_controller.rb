# app/controllers/authentication_controller.rb
module V1
	class AuthenticationController < ApplicationController
	 skip_before_action :authenticate_request

	 def authenticate
	   command = AuthenticateUser.call(params[:email], params[:password])
	   @user = User.find_by_email(params[:email])
	   if command.success?
	     render json: { auth_token: command.result }
	     @user.access_token = command.result
	     @user.save!
	   else
	     render json: { error: command.errors }, status: :unauthorized
	   end
	 end
	end
end
