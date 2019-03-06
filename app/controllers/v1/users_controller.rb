module V1
	 class UsersController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:direct_registration,:startup_user,:mentor_user,:get_user,:password_reset,:password_reset_link]
	 	# before_action  :current_user, :get_module
 	    def create
	      @user = User.new(user_params)
	      # module_access_grands = user_validate('update')
	      module_access_grands = permission_control("user","create")
	       if module_access_grands
	       	 @user.created_by = current_user.id
	       		if @user.save!
	      			command = AuthenticateUser.call(@user.email, @user.password,'direct')
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
	      				UserMailer.registration(user).deliver_later
	      				UserMailer.user_create_by_admin(user,current_user).deliver_later
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
	      		roles.each do |role|
	      			present_permissions = UserRole.where(user_id: user.id,role_id: role.id)
	      			present_permissions.destroy_all	
	      		end
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
	       	  user_roles = UserRole.where("user_id": params[:user_id])
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
      			command = AuthenticateUser.call(@user.email, @user.password,'direct')
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
      			command = AuthenticateUser.call(user.email, user.password,'direct')
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
	    	User.transaction do
		    	if user.save!
	      			command = AuthenticateUser.call(user.email, user.password,'some')
	      			if command.success?
	      				user.access_token = command.result
			    	 	user.created_by = user.id
			    	  	user.save!
	      				role = Role.all.where(name: "mentor").first
	      				role_user = RoleUser.new(user_id: user.id,role_id: role.id)
	      				if role_user.save!
	      					mentor_user = MentorUsersController.create(user.id,params[:additional_details])
	      					if mentor_user
	      						UserMailer.registration(user).deliver_later
	      						render json: {auth_token: command.result, user: return_user(user)} 
	      					else
	      						raise ActiveRecord::Rollback
	      						render json: {error: "Something happened please contact admin"},status: :unprocessable_entity
	      					end
	      				else
	      					raise ActiveRecord::Rollback
	      					render json: role_user.errors,status: :unprocessable_entity
	      				end
		    		else
						raise ActiveRecord::Rollback
		    	  		render json: { error: command.errors }, status: :unauthorized
		    		end
				else
					raise ActiveRecord::Rollback
	      			render json: user.errors, status: :unprocessable_entity
				end 
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

	  	def password_reset
	  		user = User.find(params[:user][:id])
	  		if user.present?
	  			User.transaction do
	  				# user.password = params[:user][:password]
	  				# user.password_confirmation = params[:user][:password_confirmation]
	  				user.is_first_time_logged_in = false
	  				if user.update!(user_params)
	  					render json: user ,status: :ok
	  				else
	  					render json: user.errors, status: :bad_request
	  				end	
	  			end
	  		else
	  			render json: {error: "User not found"}, status: :not_found
	  		end
	  	end

	  	def password_reset_link
	  		user = User.find_by_email(params[:user][:email])
	  		if user.present?
	  			user.is_first_time_logged_in = true
	  			if user.save!
	  				UserMailer.password_reset(user).deliver_now
	  				render json: user ,status: :ok
	  			else
	  				render json: user.errors, status: :unprocessable_entity
	  			end
	  		else
	  			render json: {error: "User not found with this email id"}, status: :not_found
	  		end
	  	end

	  	def get_user
	  		user = User.find(params[:user][:id])
	  		if user.present?
	  			render json: user, status: :ok 
	  		else
	  			render json: {error: "User not found with this ID"}, status: :not_found
	  		end
	  	end

	  	def user_profile_update
	  		user = User.find(current_user)
	  		if user.present?
	  			if user.update!(user_params)
	  				if params[:user][:mentor_user].present?
	  					mentor_user = MentorUser.find(params[:user][:mentor_user][:id])
	  					if mentor_user.update!(mentor_user_params)
	  						render json: mentor_user,status: :ok
	  					else
	  						render json: mentor_user.errors,status: :bad_request
	  					end
	  				else
	  					render json: user,status: :ok
	  				end
		  			# render json: user,status: :ok
		  		else
		  			render json: user.errors,status: :bad_request
		  		end
	  		else
	  			render json: {error: "User not found with this Auth token"},status: :bad_request
	  		end
	  	end

	  	def get_user_for_profile
	  		user = current_user
	  		mentor_profile = []
	  		if user.present?
	  			render json: user,status: :ok
	  		else
	  			render json: {error: "User not present with Auth token"},status: :bad_request
	  		end
	  	end

	  	def create_default_privileges
	  		module_access_grands = permission_control("user","update")
	  		if module_access_grands
	  			user = User.find(params[:user_id])
	  			role = Role.find(params[:role_id])
		  		module_types = ModuleType.all
		  		contract_manager_modules = ["program","startup_application","contract_form","additional_contract_information"]
		  		program_admin_modules = ["user","role","user_role","role_user"]
		  		application_manager_modules = ["current_state_form","roadmap","startup_application","application_question","app_ques_response","contract_form"]
				if role.name == "site_admin"
					module_types.each do |module_type|
						already_present = UserRole.where(user_id: user.id,role_id: role.id, module_type_id: module_type.id).first
						if !already_present.present?
							UserRole.create!(user_id: user.id,role_id: role.id, module_type_id: module_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true, user_role_type: "site")
						end
					end
				elsif role.name == "program_admin"
					program_admin_modules.each do |program_admin_type|
						module_types.each do |module_type|
							if program_admin_type != module_type.name
								already_present = UserRole.where(user_id: user.id,role_id: role.id, module_type_id: module_type.id).first
								if !already_present.present?
								UserRole.create!(user_id: user.id,role_id: role.id, module_type_id: module_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true, user_role_type: "site")									
								end								
							end
						end
					end
				elsif role.name == "program_director"
					program_admin_modules.each do |program_admin_type|
						module_types.each do |module_type|
							if program_admin_type != module_type.name
								already_present = UserRole.where(user_id: user.id,role_id: role.id, module_type_id: module_type.id).first
								if !already_present.present?
									UserRole.create!(user_id: user.id,role_id: role.id, module_type_id: module_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true, user_role_type: "site")
								end	
							end
						end
					end
				elsif role.name == "application_manager"
					application_manager_modules.each do |application_manager_type|
						module_types.each do |module_type|
							if application_manager_type != module_type.name
								already_present = UserRole.where(user_id: user.id,role_id: role.id, module_type_id: module_type.id).first
								if !already_present.present?
									UserRole.create!(user_id: user.id,role_id: role.id, module_type_id: module_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true, user_role_type: "site")
								end								
							end
						end
					end
				elsif role.name == "contract_manager"
					contract_manager_modules.each do |contract_manager_type|
						module_types.each do |module_type|
							if contract_manager_type == module_type.name
								already_present = UserRole.where(user_id: user.id,role_id: role.id, module_type_id: module_type.id).first
								if !already_present.present?
									UserRole.create!(user_id: user.id,role_id: role.id, module_type_id: module_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true, user_role_type: "site")
								end									
							end
						end
					end
				end 
				render json: {message: "privileges are successfully updated"}, status: :ok
	  		else
		   		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	  			
	  		end
	  	end

	    private

	    def user_params
	    	params.require(:user).permit(:first_name,:full_name,:last_name, :email, :phone_number,
	    								:password, :password_confirmation,:user_main_image,:designation,
	    								:facebook_link,:linkedin_link,:skype_id,:other_links,
	   									:credentials,:commitment,:isDelete,:deleted_by,:deleted_date,:created_by,:id,:user_type)
	    end
	    def role_user_params
	    	params.require(:role_user).permit(:id, :user_id, :role_id, :created_by, :isActive, :isDelete, :deleted_by, :deleted_at)
	    	
	    end
	    def mentor_user_params
	    	params.require(:mentor_user).permit(:id,:type_name,:title,:company,:linked_in_url,:facebook_url,:primary_expertise,:why_mentor,
	    		:startup_experience,:startup_experience_level,:expertise_expanded,:start_date,:end_date,:commitment,:mentorship_type,:looking_for,
	    		:visibility,:area_of_expertise,:isActive)
	    	
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

