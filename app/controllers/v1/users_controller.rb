module V1
	 class UsersController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:direct_registration,:startup_user,:mentor_user]
	 	# before_action  :current_user, :get_module
 	    def create
	      @user = User.new(user_params)
	      # module_access_grands = user_validate('update')
	      module_access_grands = permission_control("user","create")
	       if module_access_grands
	       	 @user.created_by = current_user.id
	       		if @user.save!
	      			command = AuthenticateUser.call(@user.email, @user.password)
	      			if command.success?
		    	  		render json: {auth_token: command.result, user: return_user(@user)} 
		    	 		 @user.access_token = command.result
		    	  		@user.save!
		    		else
		    	  		render json: { error: command.errors }, status: :unauthorized
		    		end
				else
	      			render json: @user.errors, status: :unprocessable_entity
				end 

	       else
	       	render json: { error: "You dont have access to create users,Please contact Site admin" }, status: :unauthorized
	       end	
	    end
	    def delete
		    if current_user.id == params[:id]
		   		user = User.find(params[:id])
	    	 	user.isDelete = true
	    	 	user.deleted_by = current_user.id
	    	 	user.deleted_date = Time.now
		   		if user.update!(user_params)
		   			render json: user , status: :ok
		   		else
		   			render json: user.errors, status: :unprocessable_entity
		   		end
		   	else
		   		 module_access_grands = permission_control("user","delete")
		   		 if module_access_grands
			   		user = User.find(params[:id])
		    	 	user.isDelete = true
		    	 	user.deleted_by = current_user.id
		    	 	user.deleted_date = Time.now
			   		if user.update!(user_params)
			   			render json: user , status: :ok
			   		else
			   			render json: user.errors, status: :unprocessable_entity
			   		end	
		   		 else
		   		 	render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
		   		 end

		   	end
	    	
	    end

	    def direct_registration
	    	 @user = User.new(user_params)
	      # binding.pry
	       	 # @user.created_by = current_user.id
       		if @user.save!
      			command = AuthenticateUser.call(@user.email, @user.password)
      			if command.success?
	    	  		render json: {auth_token: command.result, user: return_user(@user)} 
	    	 		 @user.access_token = command.result
	    	 		 @user.created_by = @user.id
	    	  		@user.save!
	    		else
	    	  		render json: { error: command.errors }, status: :unauthorized
	    		end
			else
      			render json: @user.errors, status: :unprocessable_entity
			end 

	       
	       	
	    end

	    def startup_user
	    	user = User.new(user_params)
	    	if user.save!
      			command = AuthenticateUser.call(user.email, user.password)
      			if command.success?
	    	  		render json: {auth_token: command.result, user: return_user(user)} 
	    	 		 user.access_token = command.result
	    	 		 user.created_by = user.id
	    	  		user.save!
	    	  		StartupUsersController.create(user.id,params)
	    		else
	    	  		render json: { error: command.errors }, status: :unauthorized
	    		end
			else
      			render json: @user.errors, status: :unprocessable_entity
			end 
	    	
	    end

	    def mentor_user
	    	user = User.new(user_params)
	    	if user.save!
      			command = AuthenticateUser.call(user.email, user.password)
      			if command.success?
	    	  		render json: {auth_token: command.result, user: return_user(user)} 
	    	 		 user.access_token = command.result
	    	 		 user.created_by = user.id
	    	  		user.save!
	    	  		MentorUsersController.create(user.id,params[:additional_details])
	    		else
	    	  		render json: { error: command.errors }, status: :unauthorized
	    		end
			else
      			render json: @user.errors, status: :unprocessable_entity
			end 
	    end

	    def show_user_by_type
	    	module_access_grands = permission_control("user","show")
	    	if module_access_grands
	    		users = User.where("user_type": params[:user_type])
		    	if users.present?
		    		render json: users , status: :ok
		    	else
		    		render json: {errors: user.errors}, status: :not_found
		    	end
	    	else
	    		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

	    	end

	    end

	   def edit
	   	if current_user.id == params[:user][:id]
	   		user = User.find(params[:user][:id])
	   		if user.update!(user_params)
	   			render json: user , status: :ok
	   		else
	   			render json: user.errors, status: :unprocessable_entity
	   		end
	   	else
	   		 module_access_grands = permission_control("user","update")
	   		 if module_access_grands
	   		 	user = User.find(params[:user][:id])
		   		if user.update!(user_params)
		   			render json: user , status: :ok
		   		else
		   			render json: user.errors, status: :unprocessable_entity
		   		end	
	   		 else
	   		 	render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
	   		 end

	   	end
	   end

	    private

	    def user_params
	    	params.require(:user).permit(:first_name,:full_name,:last_name, :email, :phone_number,
	    								:password, :password_confirmation,:user_main_image,:designation,
	   									:credentials,:commitment,:isDelete,:deleted_by,:deleted_date,:created_by,:id,:user_type)
	    end
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
