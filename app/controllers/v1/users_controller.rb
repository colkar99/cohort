module V1
	 class UsersController < ApplicationController
	 	skip_before_action :authenticate_request
 	    def create
	      @user = User.new(user_params)
	      byebug
	      
			if @user.save
	      		command = AuthenticateUser.call(@user.email, @user.password)
	      		if command.success?
	      			byebug
		    	  render json: {auth_token: command.result, user: return_user(@user)} 
		    	  @user.access_token = command.result
		    	  @user.save!
		    	else
		    	  render json: { error: command.errors }, status: :unauthorized
		    	end
			else
	      		render json: @user, status: :unprocessable_entity,
	                       serializer: ActiveModel::Serializer::ErrorSerializer
			end 	
	    end

	    private

	    def user_params
	    	params.require(:user).permit(:first_name,:full_name,:last_name, :email, :phone_number,
	    								:password, :password_confirmation,:user_main_image,
	   									:credentials,:commitment)
	    end
	    def return_user(user)
	    	user = {"first_name": user.first_name,
	    				"last_name": user.last_name,
	    				"phone_number": user.phone_number,
	    				"email": user.email}
	    	user			
	    end
	    
	 end
end


# if @user.save
# 	      	command = AuthenticateUser.call(@user.email, @user.password)
# 	      		if command.success?
# 	      			byebug
# 		    	  render json: {auth_token: command.result, user: return_user(@user)} 
# 		    	else
# 		    	  render json: { error: command.errors }, status: :unauthorized
# 		    	end
# else
# 	      	render json: @user, status: :unprocessable_entity,
# 	                       serializer: ActiveModel::Serializer::ErrorSerializer
# end 


# command = AuthenticateUser.call(@user.email, @user.password)
# 	        	if command.success?
# 	      			byebug
# 	      			@user.access_token = command.result
# 	      			if @user.save
# 	      				render json: @user, status: :created
# 	      			else
# 	      				render json: { error: command.errors }, status: :unauthorized
# 	      			end
# 		      	else
# 		      	  render json: @user, status: :unprocessable_entity,
# 		      	                       serializer: ActiveModel::Serializer::ErrorSerializer
# 		      	end