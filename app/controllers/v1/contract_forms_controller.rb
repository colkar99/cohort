# app/controllers/authentication_controller.rb
module V1
	class ContractFormsController < ApplicationController
		skip_before_action :authenticate_request, only: [:send_contract_details,:send_to_startup,:contract_form_response]

	
		def create
			module_grant_access = permission_control("contract_form","create")
			if module_grant_access
				startup_application = StartupRegistration.find(params[:contract_form][:startup_registration_id])
				contract_form = ContractForm.new(contract_form_params)
				contract_form.contract_send_date = Time.now
				# contract_form.contract_id = Time.now.strftime('%s')
				startup_application.contract_received_date = Time.now
				if contract_form.save!
					render json: contract_form, status: :ok
					send_to_startup(startup_app)
				else
					render json: contract_form.errors , status: :unprocessable_entity

				end
				startup_application.save!
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end

		end

		def send_contract_details
			startup_app = StartupRegistration.find_by_founder_email(params[:founder_email])
			if startup_app.present?
				contract_form = ContractForm.where("startup_registration_id": startup_app.id, "program_id": startup_app.program_id).first
				additional_contract_information = AdditionalContractInformation.find(contract_form.additional_contract_information_id)
				contract_manager = User.find(contract_form.contract_manager_id)
				render json: {startup_application: startup_app, contract_form: contract_form,
								additional_contract_information: additional_contract_information,
								contract_manager: {name: contract_manager.full_name,email: contract_manager.email,
									phone_number: contract_manager.phone_number} }, status: :ok
			else
				render json: {errors: "Your email id not found, if your new startup Please complete startup application, For any queries please contact admin"}, status: :not_found
			end
		end

		def send_to_startup(startup_app)
			if startup_app.contract_received_date.present?
				############send mail to startup-app to sign contract form#######
				binding.pry
				#################################################################
				program_status = ProgramStatus.find(4)
				startup_app.application_status = program_status.status
				startup_app.app_status_description = program_status.description
				startup_app.save!
			end
		end

		def contract_form_response
			startup_app = StartupRegistration.find(params[:startup_application][:id])
			contract_form = ContractForm.find(params[:contract_form][:id])
			program_status = ProgramStatus.find(5)
			if startup_app && contract_form && params[:contract_form][:accept_terms_condition] == true
				startup_app.contract_signed =  true
				startup_app.contract_signed_date =  Time.now
				startup_app.application_status = program_status.status
				startup_app.app_status_description = program_status.description
				contract_form.contract_signed = true
				contract_form.signed_date = Time.now
				if startup_app.update!(startup_registration_params) && contract_form.update!(contract_form_params)
					render json: startup_app , status: :ok
				else
					render json: {errors: {err_1: startup_app.errors,err_2: contract_form.errors}}, status: :unprocessable_entity
				end
			else
				render json: {errors: "not_found"}, status: :unprocessable_entity
			end
		end

		private

		def contract_form_params
	 		params.require(:contract_form).permit(:contract_manager_id,
	 												:startup_registration_id,
	 												:program_id,
	 												:additional_contract_information_id,
	 												:from_date,
	 												:to_date,
	 												:duration,
	 												:p_1_name,
	 												:p_1_address,
	 												:p_1_phone_number,
	 												:p_1_email,
	 												:p_2_name,
	 												:p_2_address,
	 												:p_2_phone_number,
	 												:p_2_email,
	 												:contract_id,
	 												:contract_send_date,
	 												:accept_terms_condition,
	 												:contract_signed,
	 												:signed_date,:isActive,
	 												:isDelete,
	 												:deleted_by,
	 												:deleted_date
	 												)
		end
		def startup_registration_params
		    params.require(:startup_application).permit(:id,
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
	end
end

#######contract params
 # t.integer "contract_manager_id"
# t.integer "startup_registration_id"
# t.integer "program_id"
# t.integer "additional_contract_information_id"
# t.datetime "from_date"
# t.datetime "to_date"
# t.string "duration"
# t.string "p_1_name"
# t.text "p_1_address"
# t.string "p_1_phone_number"
# t.string "p_1_email"
# t.string "p_2_name"
# t.text "p_2_address"
# t.string "p_2_phone_number"
# t.string "p_2_email"
# t.integer "contract_id"
# t.boolean "accept_terms_condition", default: false
# t.boolean "contract_signed", default: false
# t.datetime "signed_date"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_date"
# t.datetime "contract_send_date"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["additional_contract_information_id"], name: "index_contract_forms_on_additional_contract_information_id"
# t.index ["program_id"], name: "index_contract_forms_on_program_id"
# t.index ["startup_registration_id"], name: "index_contract_forms_on_startup_registration_id"