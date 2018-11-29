module V1
	 class UsersController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:direct_registration,:startup_user,:mentor_user]
	 	before_action  :current_user, :get_module
 	    def create
	      @user = User.new(user_params)
	      module_access_grands = user_validate('update')
	      binding.pry
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
	      			render json: @user, status: :unprocessable_entity
				end 

	       else
	       	render json: { error: "You dont have access to create users,Please contact Site admin" }, status: :unauthorized
	       end	
	    end
	    def delete
	    	 module_access_grands = user_validate('delete')
	    	 if module_access_grands
	    	 	@user = User.find(params[:user][:id])
	    	 	@user.isDelete = true
	    	 	@user.deleted_by = current_user.id
	    	 	@user.deleted_date = Time.now
	    	 	if @user.update!(user_params)
	    	 		render json: @user ,status: :created
	    	 	else
	    	 		render json: @user, status: :unprocessable_entity
	    	 	end
	    	 else
	    	 		render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

	    	 end
	    	
	    end

	    def direct_registration
	    	 @user = User.new(user_params)
	      binding.pry
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

	    def get_module
	    	ModuleType.find_by_name("user")
	    end

	    def user_validate(data)
	    	if data == "create"
	    		current_user.user_roles.each do |user_role|
	    		binding.pry
	    			if get_module.name == user_role.module_type.name
	    			binding.pry
	    				return true if user_role.create_rule == true
	    			end
	    		end
	    	return false
	    	elsif data == "update"
	    		current_user.user_roles.each do |user_role|
	    		binding.pry
	    			if get_module.name == user_role.module_type.name
	    			binding.pry
	    				return true if user_role.update_rule == true
	    			end
	    		end
	    	return false
	    	elsif data == "delete"
	    		current_user.user_roles.each do |user_role|
	    		binding.pry
	    			if get_module.name == user_role.module_type.name
	    			binding.pry
	    				return true if user_role.delete_rule == true
	    			end
	    		end
	    		return false
	    	end	
	    	
	    end

	    private

	    def user_params
	    	params.require(:user).permit(:first_name,:full_name,:last_name, :email, :phone_number,
	    								:password, :password_confirmation,:user_main_image,
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
