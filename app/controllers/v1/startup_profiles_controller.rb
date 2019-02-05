module V1
	 class StartupProfilesController < ApplicationController
	 	# skip_before_action :authenticate_request
	 	skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show , :delete,:create_password,:edit]
	 	# before_action  :current_user, :get_module
		def direct_registration
	 		# binding.pry
	 		@startup_profile = StartupProfile.new(startup_profile_params)

	 		if @startup_profile.save
	 			render json: @startup_profile ,status: :created 
	 		else
	 			render json: @startup_profile, status: :unprocessable_entity
		    end
	 	end

 	    def startup_authenticate
 	    	startup_profile = StartupProfile.find_by_email(params[:email])
    		if startup_profile && startup_profile.authenticate(params[:password])
    			render json: {"Authorization": startup_profile[:password_digest] }, status: :ok
    		else
    			render json: { error: "Invalid credentials" }, status: :unauthorized
    		end
 	    end
 	    def show
 	    	startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    	startup_registration = startup_profile.startup_registration
 	    	users = startup_profile.users
 	    	if startup_profile.present? && startup_registration.present?
 	    	# binding.pry
	 	    	# startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
	 	    	# render json: {startup_profile: startup_profile, startup_registration: startup_registration, users: users},status: :ok	 	    	
	 	    	render json: startup_profile,status: :ok	 	    	
	 	    else
	 	    	render json:  { error: "ID not found" } , status: :not_found
	 	    end
 	    end

 	    def show_all
 	    	startup_profiles = StartupProfile.all 
 	    	render json: startup_profiles, status: :ok
 	    	
 	    end
 	    def edit
 	    	startup_auth = startup_auth_check(params[:startup_profile][:id],current_user)
 	    	if startup_auth
 	    		startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    		if startup_profile.update!(startup_profile_params)
 	    			render json: startup_profile,status: :ok
 	    		else
 	    			render json: startup_profile.errors,status: :unprocessable_entity
 	    		end
 	    	else
 	    		render json: {error: "Invalid Authorization"}, status: :unauthorized

 	    	end
 	    	# if check_valid_startup
 	    	# 	startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    	# 	if startup_profile.update(startup_profile_params)
 	    	# 		render json: startup_profile , status: :ok
 	    	# 	else
 	    	# 		render json: @startup_profile, status: :unprocessable_entityr
 	    	# 	end
 	    	# else
 	    	# 	render json: {error: "Invalid Authorization"}, status: :unauthorized
 	    	# end
 	    end

 	    def add_team_member
 	    	startup_auth = startup_auth_check(params[:startup_profile_id],current_user)
 	    	# auth = check_auth_user(current_user,params[:startup_profile])
 	    	if startup_auth
 	    		User.transaction do
 	    		 	user = User.new(user_params)
	 	    		user.user_type = "startup"
	 	    		user.created_by = current_user.id
	 	    		user.password = "demo_user"
	 	    		user.password_confirmation = "demo_user"
	 	    		if user.save!
	 	    			startup_user_created = startup_user_create(user,params[:startup_profile_id])
	 	    			if startup_user_created != false
	 	    				startup_profile = StartupProfile.find(params[:startup_profile_id])
	 	    				startup_users = startup_profile.users
	 	    				UserMailer.first_time_logged_in(user).deliver_now
	 	    				render json: {startup_users: startup_users}, status: :ok
	 	    			else
	 	    				raise ActiveRecord::Rollback
	 	    				render json: {error: "Some thin has happened please contact site admin"}
	 	    			end
	 	    		else
	 	    			render json: user.errors,status: :unprocessable_entity
	 	    		end
 	    		end
 	    	else
 	    		render json: {error: "Invalid Authorization"}, status: :unauthorized
 	    	end

 	    end

 	    def edit_team_member
 	    	startup_auth = startup_auth_check(params[:startup_profile_id],current_user)
 	    	# auth = check_auth_user(current_user,params[:startup_profile])
 	    	if startup_auth
 	    		User.transaction do
 	    		 	user = User.find(params[:user][:id])
	 	    		user.user_type = "startup"
	 	    		if user.update!(user_params)
 	    				startup_profile = StartupProfile.find(params[:startup_profile_id])
	 	    			startup_users = startup_profile.users
	 	    			render json: {startup_users: startup_users}, status: :ok
	 	    		else
	 	    			render json: user.errors,status: :unprocessable_entity
	 	    		end
 	    		end
 	    	else
 	    		render json: {error: "Invalid Authorization"}, status: :unauthorized
 	    	end
 	    end

 	    def delete_team_member
 	    	startup_auth = startup_auth_check(params[:startup_profile_id],current_user)
 	    	# auth = check_auth_user(current_user,params[:startup_profile])
 	    	if startup_auth
 	    		User.transaction do
 	    		 	user = User.find(params[:user][:id])
		 	    	startup_user = StartupUser.where(user_id: user.id,startup_profile_id: params[:startup_profile_id]).first
		 	    	if startup_user.present?
		 	    		if startup_user.destroy
		 	    			if user.destroy
		 	    				startup_profile = StartupProfile.find(params[:startup_profile_id])
			 	    			startup_users = startup_profile.users
			 	    			render json: {startup_users: startup_users}, status: :ok
			 	    		else
			 	    			render json: user.errors,status: :unprocessable_entity
			 	    		end
		 	    		else
		 	    			render json: startup_user.errors,status: :unprocessable_entity
		 	    		end
		 	    	else
		 	    		render json: {error: "Somthing happend"},status: :bad_request
		 	    	end
 	    		end
 	    	else
 	    		render json: {error: "Invalid Authorization"}, status: :unauthorized
 	    	end
 	    end

 	    def admin_edit
 	    	module_grand_access = permission_control("startup_profile","update")
 	    	if module_grand_access
 	    		startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    		if startup_profile.update(startup_profile_params)
 	    			render json: startup_profile , status: :ok
 	    		else
 	    			render json: @startup_profile, status: :unprocessable_entity
 	    		end
 	    	else
 	    		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized
 	    	end
 	    end

 	    def check_auth_user(user,startup_pro)
 	    	startup_profiles = current_user.startup_profiles
 	    	startup_profiles.each do |startup_profile|
 	    		return true if startup_profile.id == startup_pro[:id]
 	    	end
 	    	false
 	    	# binding.pry
 	    	# auth = request.headers[:Authorization]
 	    	# startup_profile = StartupProfile.find_by_password_digest(auth)
 	    	# return false if !startup_profile.present?
 	    	# true
 	   
 	    end

 	    def delete
 	    	check_valid_startup = check_auth
 	    	if check_valid_startup
 	    		startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    		startup_profile.isDelete = true
 	    		startup_profile.delete_at = Time.now
 	    		startup_profile.deleted_by = "Deleted by #{startup_profile.startup_name}"
 	    		if startup_profile.update(startup_profile_params)
 	    			render json: startup_profile , status: :ok
 	    		else
 	    			render json: @startup_profile, status: :unprocessable_entity
 	    		end
 	    	else
 	    		render json: {error: "Invalid Authorization"}, status: :unauthorized
 	    	end
 	    end

 	    def user_delete
 	    		startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    		startup_profile.isDelete = true
 	    		startup_profile.delete_at = Time.now
 	    		startup_profile.deleted_by = current_user.id
 	    		if startup_profile.update(startup_profile_params)
 	    			render json: startup_profile , status: :ok
 	    		else
 	    			render json: @startup_profile, status: :unprocessable_entity
 	    		end
 	    end

 	    def startup_user_create(user,startup_profile_id)
 	    	startup_user = StartupUser.new(user_id: user.id,startup_profile_id: startup_profile_id)
 	    	if startup_user.save!
 	    		return startup_user
 	    	else
 	    		return false
 	    	end
 	    end

 	    def self.auto_populate(startup_app,contract_form)
 	    	startup_app = startup_app
 	    	contract_form = contract_form
 	    	startup_profile = StartupProfile.new
 	    	startup_profile.startup_name = startup_app.startup_name
 	    	startup_profile.startup_registration_id = startup_app.id
 	    	startup_profile.founded_date = startup_app.founded_date
 	    	startup_profile.address_line_1 = startup_app.startup_address_line_1
 	    	startup_profile.address_line_2 = startup_app.startup_address_line_2
 	    	startup_profile.city = startup_app.startup_city
 	    	startup_profile.state_province_region = startup_app.startup_state_province_region
 	    	startup_profile.zip_pincode_postalcode = startup_app.startup_zip_pincode_postalcode
 	    	startup_profile.country = startup_app.startup_country
 	    	startup_profile.geo_location = startup_app.startup_geo_location
 	    	###########################################
 	    	user = User.new
 	    	user.full_name = startup_app.founder_name
 	    	user.email = startup_app.founder_email
 	    	user.phone_number = startup_app.founder_phone_number
 	    	user.credentials = startup_app.founder_credentials
 	    	user.password = startup_app.founder_email
 	    	user.password_confirmation = startup_app.founder_email
 	    	# user.credentials = startup_app.founder_experience
 	    	user.commitment = startup_app.founder_commitment
 	    	user.user_type = "startup"
 	    	###########################################
 	    	if startup_profile.save! && user.save!
 	    		role = Role.find_by_name("startup_admin")
 	    		role_user = RoleUser.new(user_id: user.id,role_id: role.id)
 	    		role_user.save!
 	    		program_status = ProgramStatus.find_by_status("SPC")
 	    		startup_app.program_status_id = program_status.id 
 	    		startup_app.application_status = program_status.status 
 	    		startup_app.app_status_description = program_status.description
 	    		if startup_app.save!
 	    			startup_user = StartupUser.new
 	    			startup_user.user_id = user.id
 	    			startup_user.startup_profile_id = startup_profile.id
 	    			startup_user.save!
 	    			MailersController.program_startup_status(startup_app)
 	    		end 
 	    	else
 	    		render json: {errors: {err_1: startup_profile.errors,err_2: user.errors}}, status: :unprocessable_entity
 	    	end

 	    end

 	    def create_password
 	    	startup_user = User.find_by_email(params[:email])
 	    	if startup_user.present?
 	    		startup_user.password = params[:password]
	 	    	startup_user.password_confirmation = params[:password_confirmation]
	 	    	if startup_user.save!
		    		command = AuthenticateUser.call(startup_user.email, startup_user.password)
	      			if command.success?
		    	  		render json: {auth_token: command.result, user: return_user(startup_user) ,startup_profile: startup_user.startup_profiles} 
		    	 		 startup_user.access_token = command.result
		    	  		startup_user.save!
		    		else
		    	  		render json: { error: command.errors }, status: :unauthorized
		    		end
	 	    		
	 	    	else
	 	    		render json: startup_user.errors ,status: :unprocessable_entity
	 	    	end
	 	    	
 	    	else
 	    		render json: {errors: "Email not found"} ,status: :not_found

 	    	end

 	    end

 	    def show_all_details_for_startups
 	    	startup_user = current_user
 	    	startup_profile = StartupProfile.find(params[:startup_profile_id])

 	    	if current_user && startup_profile
	 	    	startup_users = startup_profile.users
	 	    	startup_application = startup_profile.startup_registration
	 	    	contract_form = ContractForm.where(startup_registration_id: startup_application.id)
	 	    	render json: {user: startup_user, startup_profile: startup_profile, startup_users: startup_users,startup_application: startup_application, contract_form: contract_form }	
 	    	else
 	    		render json: {errors: "Startup user or Startup profile not_found"}, status: :ok
 	    	end
 	    end


 	    private
 	    def startup_profile_params
		    params.require(:startup_profile).permit(:id,:startup_registration_id,:startup_name,:email,
		    									:main_image,
		    									:thumb_image,
		    									:logo_image,
		    									:founded_date,
		    									:description,
		    									:incorporated,
		    									:address_line_1,
		    									:address_line_2,
		    									:city,
		    									:state_province_region,
		    									:zip_pincode_postalcode,
		    									:country,
		    									:geo_location,
		    									:team_size,
		    									:current_stage
		    									 )
 	    end
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


######Startup Profile params########
    # t.integer "startup_registration_id"
#    t.string "startup_name"
#    t.string "password_digest"
#    t.string "email"
#    t.string "main_image"
#    t.string "thumb_image"
#    t.string "logo_image"
#    t.string "founded_date"
#    t.text "description"
#    t.boolean "incorporated"
#    t.string "address_line_1"
#    t.string "address_line_2"
#    t.string "city"
#    t.string "state_province_region"
#    t.string "zip_pincode_postalcode"
#    t.string "country"
#    t.string "geo_location"
#    t.integer "created_by"
#    t.boolean "isDelete", default: false
#    t.string "deleted_by"
#    t.string "delete_at"
#    t.integer "team_size"
#    t.string "current_stage"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false

# :startup_name,
# 		    									:founded_date,
# 		    									:website_url,
# 		    									:entity_type,
# 		    									:founder_name,
# 		    									:founder_email,
# 		    									:founder_skills,
# 		    									:founder_phone_number,
# 		    									:founder_credentials,
# 		    									:founder_experience,
# 		    									:founder_commitment,
# 		    									:startup_address_line_1,
# 		    									:startup_address_line_2,
# 		    									:startup_city,
# 		    									:startup_state_province_region,
# 		    									:startup_zip_pincode_postalcode,
# 		    									:startup_country,
# 		    									:startup_geo_location,
# 		    									:program_id,
# 		    									# :startup_profile_id,
# 		    									:program_status_id,
# 		    									:created_by,
# 		    									:isActive,
# 		    									:application_status,
# 		    									:app_status_description 


# 		    									t.string "first_name"
#     t.string "last_name"
#     t.string "full_name"
#     t.string "email"
#     t.string "password_digest"
#     t.string "access_token"
#     t.string "user_main_image"
#     t.string "credentials"
#     t.string "commitment"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.string "phone_number"
#     t.boolean "isDelete", default: false
#     t.integer "deleted_by"
#     t.datetime "deleted_date"
#     t.integer "created_by"
#     t.string "address_line_1"
#     t.string "address_line_2"
#     t.string "city"
#     t.string "state_province_region"
#     t.string "zip_pincode_postalcode"
#     t.string "country"
#     t.string "geo_location"
#     t.string "user_type"