# app/controllers/authentication_controller.rb
module V1
	class ContractFormsController < ApplicationController
	
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
				else
					render json: contract_form.errors , status: :unprocessable_entity

				end
				startup_application.save!
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
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