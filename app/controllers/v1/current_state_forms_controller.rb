module V1
	 class CurrentStateFormsController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			check_valid_auth = check_auth_user(current_user,params[:startup_profile])
			if check_valid_auth
				startup_profile = StartupProfile.find(params[:startup_profile][:id])
				startup_registration = startup_profile.startup_registration
				current_state_form = CurrentStateForm.new(current_state_form_params)
				status = ProgramStatus.find_by_status("CSFS")
				if current_state_form.save!
					startup_registration.current_state_form = true
					startup_registration.program_status_id =  status.id
					startup_registration.application_status =  status.status
					startup_registration.app_status_description =  status.description
					startup_registration.save!
					MailersController.program_startup_status(startup_registration)
					render json: current_state_form ,status: :created
				else
					render json: current_state_form.errors, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end

		end

		def show
			check_valid_auth = check_auth
			if check_valid_auth
				# binding.pry
				current_state_form = CurrentStateForm.where(program_id: params[:current_state_form][:program_id]).first
				# binding.pry
				render json: current_state_form ,status: :ok

			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized

			end
			
		end

		def admin_show
			# binding.pry
			module_grand_access = permission_control("current_state_form","show")
			if module_grand_access
				current_state_form =  CurrentStateForm.where(program_id: params[:current_state_form][:program_id], startup_registration_id: params[:current_state_form][:startup_registration_id]).first
				if current_state_form.present?
					render json: current_state_form ,status: :ok
				else
					render json: {error: "Object not found"}, status: :not_found
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end

		def edit
			check_valid_auth = check_auth_user(current_user,params[:startup_profile])
			if check_valid_auth
				current_state_form = CurrentStateForm.find(params[:current_state_form][:id])
				status = ProgramStatus.find_by_status("CSFS")
				if current_state_form.update!(current_state_form_params)
					render json: current_state_form ,status: :ok
				else
					render json: current_state_form.errors, status: :unprocessable_entity		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end			
		end 

		def admin_response
			module_grand_access = permission_control("current_state_form","update")
			current_state_form =  CurrentStateForm.find(params[:current_state_form][:id])
			if current_state_form && module_grand_access
				current_state_form.reviewer_id = current_user.id
				# MailersController.program_startup_status(startup_application)
				if current_state_form.update!(current_state_form_params)
					status = ProgramStatus.find_by_status("CSFR")
					startup_application = current_state_form.startup_registration
					# current_state_form.total_rating = params[:current_state_form][:total_rating]
					startup_application.score = 0
					startup_application.score = current_state_form.total_rating
					# startup_profile = startup_application.startup_profile
					startup_application.current_state_form_reviewed = true
					startup_application.program_status_id = status.id
					startup_application.application_status = status.status
					startup_application.app_status_description = status.description
					if startup_application.save!
						render json: {current_state_form: current_state_form,startup_registration: startup_application}, status: :ok
					else
							render json: startup_application.errors, status: :unprocessable_entity

					end
				else
					render json: current_state_form.errors, status: :unprocessable_entity

				end

			else
				render json: {error: "Invalid Authorization or result not found"}, status: :unauthorized
			end
		end

		def admin_edit_current_state_form
			module_grand_access = permission_control("current_state_form","update")
			if module_grand_access
				current_state_form = CurrentStateForm.find(params[:current_state_form][:id])
				if current_state_form.save!
					startup_application = current_state_form.startup_registration
					startup_application.score = 0
					startup_application.score = current_state_form.total_rating
					if startup_application.save!
						render json: current_state_form,status: :ok
					else
						render json: current_state_form.errors,status: :unprocessable_entity
					end
				else
					render json: current_state_form.errors,status: :unprocessable_entity
				end
			else
			end
		end


		def delete
			

		end

 	    def check_auth_user(user,startup_pro)
 	    	startup_profiles = current_user.startup_profiles
 	    	startup_profiles.each do |startup_profile|
 	    		return true if startup_profile.id == startup_pro[:id]
 	    	end
 	    	false
 	    	# binding.pry
 	    	# auth = request.headers[:Authorization]
 	    	# startup_profile = StartupProfile.find_by_password_digest(auth)
 	    	# return false if !startup_profile.present?
 	    	# true
 	   end

 	    private
 	    def current_state_form_params
		    params.require(:current_state_form).permit(:id,
		    									:startup_registration_id,
		    									:revenue,
		    									:traction,
		    									:solution_readiness,
		    									:investment,
		    									:team_velocity,
		    									:partners,
		    									:vendors,
		    									:vendors_costs,
		    									:experiment_testing,
		    									:customer_segment,
		    									:problem_validation,
		    									:channels,
		    									:governance,
		    									:startup_profile_id,
		    									:program_id,
		    									:responser_id,
		    									:reviewer_rating,
		    									:reviewer_feedback,
		    									:reviewer_id,
		    									:total_rating
		    									 )
 	    end

	 end
end


######current_state_form params########


# t.text "revenue"
# t.text "traction"
# t.text "solution_readiness"
# t.text "investment"
# t.text "team_velocity"
# t.text "partners"
# t.text "vendors"
# t.text "vendors_costs"
# t.text "experiment_testing"
# t.text "customer_segment"
# t.text "problem_validation"
# t.text "channels"
# t.text "governance"
# t.integer "startup_profile_id"
# t.integer "program_id"
   # t.integer "reviewer_rating"
   #  t.string "reviewer_feedback"
   #  t.integer "reviewer_id"
   #  t.integer "total_rating"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false