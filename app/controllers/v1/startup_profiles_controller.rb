module V1
	 class StartupProfilesController < ApplicationController
	 	# skip_before_action :authenticate_request
	 	skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		def direct_registration
	 		binding.pry
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
 	    	binding.pry
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


 	    private
 	    def startup_profile_params
		    params.require(:startup_profile).permit(:id,
		    									:startup_name,
		    									:password,
		    									:password_confirmation,
		    									:email,
		    									:main_image,
		    									:thumb_image,
		    									:logo_image,
		    									:founded_date,
		    									:description,
		    									:incorporated,
		    									:address_line_1,:address_line_2,
		    									:city,:state_province_region,
		    									:zip_pincode_postalcode,:country,
		    									:geo_location,:team_size,:current_stage
		    									 )
 	    end

	 end
end


######Startup Profile params########

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