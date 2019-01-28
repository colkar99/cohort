# app/controllers/authentication_controller.rb
module V1
	class ContractFormsController < ApplicationController
		skip_before_action :authenticate_request, only: [:send_contract_details,:send_to_startup,:contract_form_response,:show_contract_for_startup]

	
		def self.create(startup_app)
			binding.pry
				startup_application = startup_app
				contract_form = ContractForm.new
				program_status = ProgramStatus.where("status": "CFR").first
				contract_form.startup_registration_id = startup_application.id
				contract_form.program_id = startup_application.program_id
				contract_form.additional_contract_information_id = 1
				contract_form.contract_send_date = Time.now
				contract_form.p_1_name = "Startup-iginte"
				contract_form.p_1_email = "Startup-iginte@gmail.com"
				contract_form.p_1_address = "demo p_1_address"
				contract_form.p_1_phone_number = "demo_phone_number"
				contract_form.p_2_name = startup_application.startup_name
				contract_form.p_2_email = startup_application.founder_email
				contract_form.p_2_address = startup_application.startup_address_line_1 + ",/n" + startup_application.startup_address_line_1 + ",/n" + startup_application.startup_city + ",/n" + startup_application.startup_state_province_region + ",/n" + startup_application.startup_zip_pincode_postalcode + ",/n" + startup_application.startup_country
				contract_form.p_2_phone_number = "demo_phone_number"
				if contract_form.save!
					startup_application.program_status_id = program_status.id
					startup_application.application_status = program_status.status
					startup_application.app_status_description = program_status.description
					startup_application.contract_received_date = Time.now
					startup_application.save!
					render json: {startup_application: startup_application, contract_form: contract_form}, status: :ok
				else
					render json: {errors:contract_form.errors },status: :unprocessable_entity

				end
				MailersController.program_startup_status(startup_application)
		end


		def send_contract_details ##startup has to login using founder email and sign for contract
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

		def contract_form_response
			startup_app = StartupRegistration.find(params[:startup_application][:id])
			contract_form = ContractForm.find(params[:contract_form][:id])
			program_status = ProgramStatus.find_by_status("CSWFP")
			if startup_app && contract_form && params[:contract_form][:accept_terms_condition] == true
				# startup_app.contract_signed =  true
				# startup_app.contract_signed_date =  Time.now
				startup_app.application_status = program_status.status
				startup_app.app_status_description = program_status.description
				startup_app.program_status_id = program_status.id
				contract_form.contract_signed = true
				contract_form.signed_date = Time.now
				if startup_app.update!(startup_registration_params) && contract_form.update!(contract_form_params)
					MailersController.program_startup_status(startup_app)
					render json: startup_app , status: :ok

				else
					render json: {errors: {err_1: startup_app.errors,err_2: contract_form.errors}}, status: :unprocessable_entity
				end
			else
				render json: {errors: "not_found"}, status: :unprocessable_entity
			end
		end

		def get_contract_form_by_approval
			module_grant_access = permission_control("contract_form","show")
			if module_grant_access
				startup_applications = StartupRegistration.where("application_status": "CSWFP","program_id": params[:program_id])
				contract_forms = ContractForm.where("program_id": params[:program_id])
				render json: {startup_applications: startup_applications , contract_forms: contract_forms}, status: :ok
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end

		def approved_by_admin
			module_grant_access = permission_control("contract_form","update")
			if module_grant_access
				contract_form = ContractForm.find(params[:contract_form_id])
				startup_application = StartupRegistration.find(contract_form.startup_registration_id)
				program_status = ProgramStatus.find_by_status("CFA")
				if contract_form && startup_application
					contract_form.manager_approval = true
					contract_form.manager_approved_date = Time.now
					startup_application.program_status_id = program_status.id
					startup_application.application_status = program_status.status
					startup_application.app_status_description = program_status.description
					if startup_application.save! && contract_form.save!
						MailersController.program_startup_status(startup_application)
						StartupProfilesController.auto_populate(startup_application,contract_form)
						render json: {startup_application: startup_application,contract_form: contract_form},status: :ok
					else
						render json: {errors:{err_1: startup_application.errors, err_2: contract_form.errors}},status: :unprocessable_entity

					end
				else
					render json: {errors: "not found"},status: :not_found

				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end

		end
		def create_contract_form
			module_grant_access = permission_control("contract_form","create")
			# module_grant_access = true
			if module_grant_access
				startup_application = StartupRegistration.find(params[:contract_form][:startup_registration_id])
				program_status = ProgramStatus.find_by_status("CFR")
				contract_form = ContractForm.new(contract_form_params)
				contract_form.contract_send_date = Time.now
				contract_form.contract_manager_id = current_user.id
				if contract_form.save!
					startup_application.program_status_id = program_status.id
					startup_application.application_status = program_status.status
					startup_application.app_status_description = program_status.description
					startup_application.contract_received_date = Time.now
					if startup_application.save!
						############send mail to sign contract form###############
						render json: contract_form, status: :ok
					else
						render json: startup_application.errors , status: :unprocessable_entity
					end
				else
					render json: contract_form.errors, status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end

		def update_contract_form
			module_grant_access = permission_control("contract_form","update")
			# module_grant_access = true
			if module_grant_access
				startup_application = StartupRegistration.find(params[:contract_form][:startup_registration_id])
				program_status = ProgramStatus.find_by_status("CFR")
				contract_form = ContractForm.find(params[:contract_form][:id])
				if contract_form.update!(contract_form_params)
					if startup_application.save!
						############send mail to sign contract form###############
						render json: contract_form, status: :ok
					else
						render json: startup_application.errors , status: :unprocessable_entity
					end
				else
					render json: contract_form.errors, status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end

		def show_contract_for_startup
			startup_application = StartupRegistration.find(params[:startup_registration_id])
			if startup_application.present?
				contract_form = startup_application.contract_form
				if contract_form.present?
					render json: {startup_application: startup_application, contract_form: contract_form},status: :ok
				else
					render json: {error: "Contract form not found"}, status: :not_found
				end
			else
				render json: {error: "Startup Application not found"}, status: :not_found
			end
		end

		def startup_response_for_contract
			contract_form = ContractForm.find(params[:contract_form][:id])
			startup_application = StartupRegistration.find(params[:contract_form][:startup_registration_id])
			program_status = ProgramStatus.find_by_status("CSWFP")
			if contract_form.present? && startup_application
				if params[:contract_form][:accept_terms_condition]
					contract_form.contract_signed = true;
					contract_form.signed_date = Time.now;
					if contract_form.update!(contract_form_params)
						startup_application.program_status_id = program_status.id
						startup_application.application_status = program_status.status
						startup_application.app_status_description = program_status.description
						startup_application.contract_signed = true
						startup_application.contract_signed_date = Time.now
						if startup_application.save!
							#######send mail to application manager#######
							render json: {contract_form: contract_form,startup_application: startup_application}, status: :ok
						else
							render json: startup_application.errors ,status: :unprocessable_entity
						end
					else
						render json: contract_form.errors,status: :unprocessable_entity
					end
				else
					render json: {message: "please accept terms and condition"}, status: :not_found
				end
			else
				render json: {error: "Contract form not found"}, status: :unprocessable_entity
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
	 												:deleted_date,
	 												:manager_approval,
	 												:manager_approved_date
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
		    									:app_status_description,
		    									:contract_signed,
		    									:contract_signed_date,
		    									:contract_received_date 
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
# t.boolean "manager_approval", default: false
# t.datetime "manager_approved_date"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["additional_contract_information_id"], name: "index_contract_forms_on_additional_contract_information_id"
# t.index ["program_id"], name: "index_contract_forms_on_program_id"
# t.index ["startup_registration_id"], name: "index_contract_forms_on_startup_registration_id"
