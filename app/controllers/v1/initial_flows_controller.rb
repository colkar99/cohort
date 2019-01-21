# app/controllers/authentication_controller.rb
module V1
	class InitialFlowsController < ApplicationController
	 skip_before_action :authenticate_request, only: [:get_application_current_form_data]
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
	 def request_current_state_form
 	   	module_grand_access = permission_control("startup_application","update")
   		if module_grand_access
   			program_status = ProgramStatus.find_by_status("CSFI")
   			startup_application = StartupRegistration.find(params[:startup_registration_id])
   			status_change = status_change_for_app(startup_application,"CSFI")
   			if status_change
   				###########Send mail to contract manager to send contract form####
   				render json: startup_application, status: :ok
   			else
 				render json: {error: "Something happened please contact support"}, status: :unprocessable_entity

   			end
   		else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
   		end
 	 end

 	 def reminder_mail_for_current_state
 	 	module_grand_access = permission_control("startup_application","update")
 	 	if module_grand_access
 	 		startup_application = StartupRegistration.find(params[:startup_registration_id])
 	 		if startup_application
 	 			render json: {success: "Reminder send successfully"}
 	 		else
 	 			render json: {error: "Application not found"}, status: :not_found
 	 		end
 	 	else
 	 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

 	 	end
 	 end

 	 def get_application_current_form_data
 		startup_registration = StartupRegistration.find(params[:startup_application_id])
 		if startup_registration
 			render json: startup_registration, status: :ok
 		else
 			render json: {error: "not found"},status: :not_found
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
