module V1
	 class StartupProfilesController < ApplicationController
	 	# skip_before_action :authenticate_request
	 	skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		def direct_registration
	 		# binding.pry
	 		@startup_profile = StartupProfile.new(startup_profile_params)

	 		if @startup_profile.save
	 			render json: @startup_profile ,status: :created 
	 		else
	 			render json: @startup_profile, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
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
 	    	check_valid_startup = check_auth
 	    	if check_valid_startup
 	    	# binding.pry
	 	    	startup_profile = StartupProfile.find_by_password_digest(request.headers[:Authorization])
	 	    	if startup_profile
	 	    		render json: startup_profile,status: :ok
	 	    	else
	 	    		render json:  { error: "ID not found" } , status: :not_found
	 	    	end
	 	    else
	 	    	render json: {error: "Invalid Authorization"}, status: :unauthorized
	 	    end
 	    end

 	    def show_all
 	    	startup_profiles = StartupProfile.all 
 	    	render json: startup_profiles, status: :ok
 	    	
 	    end
 	    def edit
 	    	check_valid_startup = check_auth
 	    	if check_valid_startup
 	    		startup_profile = StartupProfile.find(params[:startup_profile][:id])
 	    		if startup_profile.update(startup_profile_params)
 	    			render json: startup_profile , status: :ok
 	    		else
 	    			render json: @startup_profile, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
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
 	    			render json: @startup_profile, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
 	    		end
 	    	else
 	    		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized
 	    	end
 	    end

 	    def check_auth
 	    	auth = request.headers[:Authorization]
 	    	startup_profile = StartupProfile.find_by_password_digest(auth)
 	    	return false if !startup_profile.present?
 	    	true
 	   
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
 	    			render json: @startup_profile, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
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
 	    			render json: @startup_profile, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
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
 	    	# user.credentials = startup_app.founder_experience
 	    	user.commitment = startup_app.founder_commitment
 	    	user.user_type = "startup"
 	    	###########################################

 	    end


 	    private
 	    def startup_profile_params
		    params.require(:startup_profile).permit(:id,
		    									:startup_registration_id,
		    									:startup_name,
		    									:email,
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

:startup_name,
		    									:founded_date,
		    									:website_url,
		    									:entity_type,
		    									:founder_name,
		    									:founder_email,
		    									:founder_skills,
		    									:founder_phone_number,
		    									:founder_credentials,
		    									:founder_experience,
		    									:founder_commitment,
		    									:startup_address_line_1,
		    									:startup_address_line_2,
		    									:startup_city,
		    									:startup_state_province_region,
		    									:startup_zip_pincode_postalcode,
		    									:startup_country,
		    									:startup_geo_location,
		    									:program_id,
		    									# :startup_profile_id,
		    									:program_status_id,
		    									:created_by,
		    									:isActive,
		    									:application_status,
		    									:app_status_description 


		    									t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.string "access_token"
    t.string "user_main_image"
    t.string "credentials"
    t.string "commitment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_date"
    t.integer "created_by"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state_province_region"
    t.string "zip_pincode_postalcode"
    t.string "country"
    t.string "geo_location"
    t.string "user_type"