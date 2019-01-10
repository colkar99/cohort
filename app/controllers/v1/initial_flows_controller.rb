# app/controllers/authentication_controller.rb
module V1
	class InitialFlowsController < ApplicationController
	 # skip_before_action :authenticate_request, only: [:show_ques_related_program,:application_question_response]
	 def startup_accept_by_admin
	 	module_grand_access = permission_control("startup_application","update")
	 	if module_grand_access
	 		startup_registration = StartupRegistration.find(params[:startup_registration_id])
	 		if startup_registration
	 			startup_ques_response = startup_registration.app_ques_responses
	 			status = check_startups_accept(startup_ques_response)
	 			if status
	 				status_change = status_change_for_app(startup_registration,"AA")
	 				if status_change
	 					###########Send mail to contract manager to send contract form####
	 					render json: startup_registration, status: :ok
	 				else
	 					render json: {error: "Something happened please contact support"}, status: :unprocessable_entity
	 				end
	 			else
	 				render json: {error: "please review all responses, have some pending reviews"}, status: :unprocessable_entity
	 			end
	 		else
	 			render json: {error: "Startup Registration not found"}, status: :unprocessable_entity
	 		end
	 	else
	 	end
	 end

	 def startup_reject_by_admin
	 	module_grand_access = permission_control("startup_application","update")
	 	if module_grand_access
	 		startup_registration = StartupRegistration.find(params[:startup_registration_id])
	 		if startup_registration
 				status_change = status_change_for_app(startup_registration,"AR")
 				if status_change
 					###########Send mail to contract manager to send contract form####
 					render json: startup_registration, status: :ok
 				else
 					render json: {error: "Something happened please contact support"}, status: :unprocessable_entity
 				end
	 		else
	 			render json: {error: "Startup Registration not found"}, status: :unprocessable_entity
	 		end
	 	else
	 	end
	 end

	 private
	 def check_startups_accept(app_ques_responses)
		app_ques_res = app_ques_responses
		app_ques_res.each do |app_res|
			if app_res[:admin_response] == false
					return false
			end
		end
		return true
	 end
	 def status_change_for_app(startup_registration,status_name)
	 	status = ProgramStatus.find_by_status(status_name)
	 	if status
	 		startup_registration.program_status_id = status.id
			startup_registration.application_status = status.status
			startup_registration.app_status_description = status.description
			startup_registration.score = startup_registration.app_ques_responses.sum(:reviewer_rating)
			if startup_registration.save!
				return true
			else
				return false
			end
	 	else
	 		return false
	 	end
	 	
	 end
	end
end
