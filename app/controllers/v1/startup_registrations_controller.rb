module V1
	 class StartupRegistrationsController < ApplicationController
	 	# skip_before_action :authenticate_request
	 	skip_before_action :authenticate_request, only: [:create,:app_ques_res,:create]
	 	# before_action  :current_user, :get_module
		
		def create
			# binding.pry
			# md_access = permission_control("startup_application","create")
			# binding.pry
			# return 

			startup_registration = StartupRegistration.new(startup_registration_params)
			app_status = ProgramStatus.find_by_status("PR")
			startup_registration.program_status_id = app_status.id
			 startup_registration.application_status = app_status.status
			 startup_registration.app_status_description = app_status.description
			if startup_registration.save!
				render json: startup_registration ,status: :created
				MailersController.program_startup_status(startup_registration)
			else
				render json: startup_registration.errors, status: :unprocessable_entity
	                       
			end

		end

		def show_registered_startup #######show startups based on programs##########
			module_grant_access = permission_control("startup_application","show")
			if module_grant_access
				startup_apps = StartupRegistration.where("program_id": params[:program_id])
				render json: startup_apps ,status: :ok
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end

		def show_all_details #########show startups detailed information############
			module_grant_access = permission_control("startup_application","show")
			if module_grant_access
				startup_app = StartupRegistration.find(params[:startup_application_id])
				startup_app_status = startup_app.program_status
				program = startup_app.program
				program_location = program.ProgramLocation
				program_reg_ques = program.application_questions
				startup_app_ques_res = startup_app.app_ques_responses
				program_status = ProgramStatus.where("stage": "initial")
				render json: {startup_application: startup_app,
								startup_application_status: startup_app_status,
								program: program,
								program_location: program_location,
								application_question: program_reg_ques,
								startup_responses: startup_app_ques_res,
								program_status: program_status}
			
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end

		end


		def app_ques_res
			app_ques_res = AppQuesResponse.new(app_ques_response_params)
			app_ques_res.startup_response = true
			if app_ques_res.save!
				render json: app_ques_res,status: :created
			else
				render json: app_ques_res.errors , status: :unprocessable_entity
			end
			
		end

		def app_ques_res_admin
			module_grant_access = permission_control("app_ques_response","update")
			if module_grant_access
				app_ques_res = AppQuesResponse.find(params[:app_ques_response][:id])
				app_ques_res.admin_response = true 
				app_ques_res.reviewed_by = current_user.id 
				if app_ques_res.update!(app_ques_response_params)
					render json: app_ques_res,status: :ok
				else
					render json: app_ques_res.errors , status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end

			
		end

		def set_app_status
			module_grant_access = permission_control("startup_application","update")
			if module_grant_access
				program_status = ProgramStatus.find(params[:program_status_id])
				startup_app = StartupRegistration.find(params[:program_registration][:id])
				startup_app.program_status_id = program_status.id
				startup_app.application_status = program_status.status
				startup_app.app_status_description = program_status.description
				if startup_app.update!(startup_registration_params)
					MailersController.program_startup_status(startup_app)
					if startup_app.program_status.status == "AA"
						ContractFormsController.create(startup_app)
					end
					render json: startup_app ,status: :ok

				else
					render json: startup_app.errors , status: :unprocessable_entity

				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end


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
		    									:isActive,
		    									:application_status,
		    									:app_status_description 
		    									 )
 	    end

 	    def app_ques_response_params
 	    	 params.require(:app_ques_response).permit(:application_question_id,
 	    	 											:response,
 	    	 											:reviewer_rating,
 	    	 											:reviewer_feedback,
 	    	 											:program_location_id,
 	    	 											:startup_registration_id,
 	    	 											:startup_response,
 	    	 											:admin_response,
 	    	 											:reviewed_by)
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
# t.string "application_status"
# t.string "app_status_description"
# t.index ["program_id"], name: "index_startup_registrations_on_program_id"
# t.index ["program_status_id"], name: "index_startup_registrations_on_program_status_id"
# t.index ["startup_profile_id"], name: "index_startup_registrations_on_startup_profile_id"

#########App Ques response  params################
# t.integer "application_question_id"
# t.text "response"
# t.integer "reviewer_rating"
# t.text "reviewer_feedback"
# t.integer "program_location_id"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.integer "startup_registration_id"
# t.boolean "startup_response", default: false
# t.boolean "admin_response", default: false
# reviewed_by: integer
# t.index ["application_question_id"], name: "index_app_ques_responses_on_application_question_id"
# t.index ["program_location_id"], name: "index_app_ques_responses_on_program_location_id"
# t.index ["startup_registration_id"], name: "index_app_ques_responses_on_startup_registration_id"
