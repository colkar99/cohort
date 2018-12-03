module V1
	 class StartupRegistrationsController < ApplicationController
	 	skip_before_action :authenticate_request
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			# binding.pry
			# md_access = permission_control("startup_application","create")
			# binding.pry
			# return 
			startup_registration = StartupRegistration.new(startup_registration_params)
			startup_registration.program_status_id = 1
			if startup_registration.save!
				render json: startup_registration ,status: :created
			else
				render json: startup_registration, status: :unprocessable_entity
	                       
			end

		end

		def show_all_details
			binding.pry
			startup_app = StartupRegistration.find(params[:startup_application_id])
			program = startup_app.program
			program_location = program.ProgramLocation
			program_reg_ques = program.program_registration_questions
			
			binding.pry
		end

		def edit
			
		end

		def delete
			

		end


 	    private
 	    def startup_registration_params
		    params.require(:program_registration).permit(:id,
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
		    									:isActive 
		    									 )
 	    end

	 end
end


######Startup registration params########

# t.string "startup_name"
# t.string "founded_date"
# t.string "website_url"
# t.string "entity_type"
# t.integer "program_id"
# t.integer "startup_profile_id"
# t.integer "program_status_id"
# t.string "founder_name"
# t.string "founder_email"
# t.string "founder_phone_number"
# t.text "founder_skills"
# t.text "founder_credentials"
# t.text "founder_experience"
# t.text "founder_commitment"
# t.string "startup_address_line_1"
# t.string "startup_address_line_2"
# t.string "startup_city"
# t.string "startup_state_province_region"
# t.string "startup_zip_pincode_postalcode"
# t.string "startup_country"
# t.string "startup_geo_location"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "created_by"
# t.boolean "isDelete", default: false
# t.boolean "isActive", default: true
# t.datetime "deleted_at"
# t.string "deleted_by"
# t.index ["program_id"], name: "index_startup_registrations_on_program_id"
# t.index ["program_status_id"], name: "index_startup_registrations_on_program_status_id"
# t.index ["startup_profile_id"], name: "index_startup_registrations_on_startup_profile_id"