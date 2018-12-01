module V1
	 class StartupRegistrationsController < ApplicationController
	 	skip_before_action :authenticate_request
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			# binding.pry
			startup_registration = StartupRegistration.new(startup_registration_params)
			startup_registration.program_status_id = 1
			if startup_registration.save!
				render json: startup_registration ,status: :created
			else
				render json: startup_registration, status: :unprocessable_entity
	                       
			end

		end

		def show
			
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
		    									:program_id,
		    									:startup_profile_id,
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