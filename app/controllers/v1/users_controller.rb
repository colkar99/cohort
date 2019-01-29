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

	    def create_user_by_admin
	    	user = User.new(user_params)
	    	role_user = RoleUser.new
	      # module_access_grands = user_validate('update')
	      module_access_grands = permission_control("user","create")
	       if module_access_grands
	       	  user.created_by = current_user.id
	       	  user.password = "demo123"
	       	  user.password_confirmation = "demo123"
	       		if  user.save!
	      			role_user.user_id = user.id
	      			role_user.role_id = params[:role][:role_id].to_i
	      			if role_user.save!
	      				role = user.roles
	      				###send mail to registerd user
	      				UserMailer.registration(user).deliver_now
	      				render json: {user: user, role: role} , status: :created
	      			else
	      				render json: role_user.errors, status: :unprocessable_entity

	      			end
				else
	      			render json: user.errors, status: :unprocessable_entity
				end 

	       else
	       	render json: { error: "You dont have access to create users,Please contact Site admin" }, status: :unauthorized
	       end	
	    end

	    def update_user_by_admin
	    	user = User.find(params[:user][:id])
	    	roles = user.roles
	    	role_user = RoleUser.new
	      module_access_grands = permission_control("user","create")
	      if module_access_grands
	      	if params[:role][:role_id].length == 0
	      		if user.update!(user_params)
	      			render json: {user: user,roles: roles},status: :ok
	      		else
	      			render json: user.errors, status: :unprocessable_entity

	      		end
	      	else
	      		roles.destroy_all
	  			if user.update!(user_params)
	  				role_user = RoleUser.new
	  				role_user.user_id = user.id
	  				role_user.role_id = params[:role][:role_id].to_i
	      			if role_user.save!
	      				roles = user.roles
	      				###send mail to registerd user
	      				render json: {user: user} , status: :ok
	      			else
	      				render json: role_user.errors, status: :unprocessable_entity

	      			end	      				
	  			else
	  				render json: user.errors, status: :unprocessable_entity
	  			end
	      	end
	      else
	       	render json: { error: "You dont have access to create users,Please contact Site admin" }, status: :unauthorized	      	
	      end
	    end

	    def get_user_detail
	    	user = current_user
	    	roles = current_user.roles
	    	# binding.pry
	    	if user.present? && roles.present?
		    	render json: {user: user, roles: roles},status: :ok 
	    	else
	    		render json: {errors: user.errors}, status: :unprocessable_entity

	    	end
	    end

	    def get_all_users
	    	module_access_grands = permission_control("user","show")
	       if module_access_grands
	       	  users = User.all

	       	 render json: users, status: :ok
	       else
	       	render json: { error: "You dont have access to create users,Please contact Site admin" }, status: :unauthorized
	       end		
	    	
	    end
	    def get_user_related_datas
	    	module_access_grands = permission_control("user","show")
	       if module_access_grands
	       	  datas = []
	       	  roles = []
	       	  privileges = []
	       	  modules = ModuleType.all
	       	  user = User.find(params[:user_id])
	       	  role = user.roles
	       	  role.each do |role|
	       	  	roles.push({id: role.id, name: role.name})
	       	  end
	       	  user_roles = UserRole.where("user_id": params[:user_id],"isDelete": false)
	       	  user_roles.each do |usrRole |
	       	  	privileges.push({id: usrRole.id,
	       	  						user_id: usrRole.user_id ,role_id: usrRole.role_id ,role_name: usrRole.role.name,
	       	  						module_type_id: usrRole.module_type_id, module_type_name: usrRole.module_type.name,
	       	  						create_rule: usrRole.create_rule,
	       	  						update_rule: usrRole.update_rule,delete_rule: usrRole.delete_rule,
	       	  						show_rule: usrRole.show_rule})
	       	  end	       	  
	       	  datas.push(user: user,roles: roles,privileges: privileges,modules: modules)
	       	 render json: datas, status: :ok
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
	    def role_user_params
	    	params.require(:role_user).permit(:id, :user_id, :role_id, :created_by, :isActive, :isDelete, :deleted_by, :deleted_at)
	    	
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

