# app/controllers/authentication_controller.rb
module V1
	class InitialFlowsController < ApplicationController
	 skip_before_action :authenticate_request, only: [:get_application_current_form_data,:current_state_form_submit]
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
	 	   	render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	
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
   			startups = []
   			program = {}
   			program_dir = {}
   			program_admin = {}
   			application_manager = {}
   			program_status = ProgramStatus.find_by_status("CSFI")
   			params[:startup_app_ids].each do |id|
   				startup_application = StartupRegistration.find(id)
   				startups.push(startup_application)
   				program = startup_application.program
				program_admin = User.find(program.program_admin)
				program_dir = User.find(program.program_director)
				application_manager = User.find(program.application_manager)
   				status_change = status_change_for_app(startup_application,"CSFI")
   				if !status_change
   					###########Send mail to contract manager to send contract form####
   					render json: {error: "Something happened please contact support"}, status: :unprocessable_entity
	   			end
	   			 FlowMailer.csfi(startup_application).deliver_later
   			end
   			FlowMailer.admin_notification_for_current_state_form(program_admin,program_dir,application_manager,startups,program).deliver_later
   			render json: {message: "Current state form initilized"}, status: :ok
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

 	 def current_state_form_submit
 	 	current_state_form = CurrentStateForm.new(current_state_form_params)
 	 	startup_registration = StartupRegistration.find(params[:current_state_form][:startup_registration_id])
 	 	status = status_change_for_app(startup_registration,'CSFS')
 	 	if status
 	 		if current_state_form.save!
 	 			render json: current_state_form, status: :ok
 	 		else
 	 			render json: current_state_form.errors, status: :unprocessable_entity
 	 		end
 	 	else
 	 		render json: {error: "Something happened please contact support"}, status: :unprocessable_entity

 	 	end
 	 end

 	 def startup_accept_by_admin_bulk
	 	module_grand_access = permission_control("startup_application","update")
	 	startups = []
		program = {}
		program_admin = {}
		program_dir = {}
		application_manager = {}
		contract_manager = {}
	 	if module_grand_access
	 		program_status = ProgramStatus.find_by_status("AA")
   			params[:startup_app_ids].each do |id|
	 			startup_application = StartupRegistration.find(id)
	 			current_state_form = CurrentStateForm.where(startup_registration_id: id).first
	 			startup_application.program_status_id = program_status.id
				startup_application.application_status = program_status.status
				startup_application.app_status_description = program_status.description
				startup_application.score = current_state_form.total_rating
				program = startup_application.program
				program_admin = User.find(program.program_admin)
				program_dir = User.find(program.program_director)
				application_manager = User.find(program.application_manager)
				contract_manager = User.find(program.contract_manager)
				if startup_application.save!
					startups.push(startup_application)
					FlowMailer.accepted(startup_application).deliver_later
					puts "Updated startup_application details"
				else
					render json: {errors: "Something happend please contact supprt team"}
				end
	 		end
	 			FlowMailer.notification_contract_manager(program_admin,program_dir,application_manager,contract_manager,startups,program).deliver_later
	 		   render json: {message: "Applications are accepted "}, status: :ok
	 	else
	 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

	 	end
	 end

 	 def startup_reject_by_admin_bulk
	 	module_grand_access = permission_control("startup_application","update")
	 	if module_grand_access
	 		program_status = ProgramStatus.find_by_status("AR")
	 		params[:startup_app_ids].each do |id|
	 			startup_application = StartupRegistration.find(id)
	 			current_state_form = CurrentStateForm.where(startup_registration_id: id).first
	 			startup_application.program_status_id = program_status.id
				startup_application.application_status = program_status.status
				startup_application.app_status_description = program_status.description
				startup_application.score = current_state_form.total_rating
				if startup_application.save!
					puts "Updated startup_application details"
				else
					render json: {errors: "Something happend please contact supprt team"}
				end
	 		end
	 		   render json: {message: "Applications are accepted "}, status: :ok
	 	else
	 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

	 	end
	 end


 	 
	 private

    def current_state_form_params
    params.require(:current_state_form).permit(:id,:startup_registration_id,:revenue,:traction,:solution_readiness,
    											:investment,:team_velocity,:partners,:vendors,:vendors_costs,
    									:experiment_testing,:customer_segment,:problem_validation,:channels,:governance,
    									:startup_profile_id,:program_id,:responser_id,:reviewer_rating,
    									:reviewer_feedback,:reviewer_id,:total_rating
    									 )
    end
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
