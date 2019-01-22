# app/controllers/authentication_controller.rb
module V1
	class ContractFlowsController < ApplicationController
	 # skip_before_action :authenticate_request

	 def get_additional_contract_information
	 	module_grant_access = permission_control("additional_contract_information","show")
	 	if module_grant_access
	 		add_con_info = AdditionalContractInformation.all
	 		if add_con_info
	 			render json: add_con_info, status: :ok
	 		else
	 			render json: {error: "Not found"}, status: :unprocessable_entity
	 		end
	 	else
			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 		
	 	end
	 end
	end
end
