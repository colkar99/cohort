module V1
	 class StartupProfilesController < ApplicationController
	 	skip_before_action :authenticate_request, only: :direct_registration
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
 	    	binding.pry
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