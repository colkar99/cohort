module V1
	class ApplicationQuestionsController < ApplicationController
	 		 	skip_before_action :authenticate_request, only: [:show_ques_related_program,:application_question_response]

	 	def create
		 	module_grand_access = permission_control("application_question","create")
		 	application_question = ApplicationQuestion.new(application_question_params)
		 	application_question.created_by = current_user.id
		 	if module_grand_access
		 			if application_question.save
			    	  	render json: application_question ,status: :created 
					else
		      			render json: application_question, status: :unprocessable_entity
					end 
		 	else
		 		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized

		 	end
		end
		def show_ques_related_program
			program = Program.find(params[:program_id])
			program_questions = program.application_questions
			if program_questions.present?
				render json: program_questions, status: :ok
			else
				render json: {erros: "Ooops! Questions are not found for this program"} ,status: :not_found
			end
		end
######
	 	def edit
		 	# binding.pry
		 	module_grand_access = permission_control("application_question","update")
		 	if module_grand_access
			 	@program_reg_que = ApplicationQuestion.find(params[:program_registration_question][:id])
			 	if @program_reg_que.update(application_question_params)
			 		render json: @program_reg_que ,status: :ok 
			 	else
			 		render json: @program_reg_que, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
			module_grand_access = permission_control("application_question","show")
		 	if module_grand_access
			 	application_questions = ApplicationQuestion.all
				render json: application_questions ,status: :ok
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 
			
		end
		########
		def delete
			# binding.pry
		 	module_grand_access = permission_control("application_question","delete")
		 	if module_grand_access
			 	application_ques = ApplicationQuestion.find(params[:program_registration_question][:id])
			 	application_ques.isDelete = true
			 	application_ques.deleted_date = Time.now
			 	application_ques.deleted_by = current_user.id
			 	if application_ques.update(application_question_params)
			 		render json: application_ques ,status: :ok 
			 	else
			 		render json: application_ques, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end

		def application_question_response
			program = Program.find(params[:program_id])
			startup_application = StartupRegistration.find(params[:startup_application_id])
			app_questions_responses = params[:application_ques_response][:application_question]
			app_questions_responses.each do |app_que|
				application_ques = AppQuesResponse.new
				application_ques.application_question_id = app_que[:application_question_id]
				application_ques.response = app_que[:response]
				application_ques.startup_response = true
				application_ques.program_location_id = program.ProgramLocation_id
				application_ques.startup_registration_id = params[:startup_application_id]
				if application_ques.save!
					puts "Created"
				else
					render application_ques.errors, status: :unprocessable_entity
				end
			end
			application_ques_responses = startup_application.app_ques_responses
			render json: application_ques_responses , status: :created
		end
		def get_application_response_questions
			module_grand_access = permission_control("application_question","show")
			if module_grand_access
				# startup = StartupRegistration.find(params[:startup_registration_id])
				applications_res_ques = AppQuesResponse.where("startup_registration_id": params[:startup_registration_id])
				if applications_res_ques.present?
					render json:  applications_res_ques , status: :ok
				else
					render json: {error: "not found"} , status: :unprocessable_entity
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end
		
		def app_ques_res_admin
			module_grand_access = permission_control("app_ques_response","update")
			if module_grand_access
				startup_registration_id = 0;
				application_question_response = params[:application_questions_response]
				application_question_response.each do |app_que_res,value|
					application_ques_res = AppQuesResponse.find(value[:id])
					application_ques_res.reviewer_feedback = value[:reviewer_feedback]
					application_ques_res.reviewer_rating = value[:reviewer_rating]
					application_ques_res.admin_response = true
					if application_ques_res.reviewer_feedback.present?  && application_ques_res.reviewer_rating.present?
						if application_ques_res.save!
							puts "Updated"
							startup_registration_id = application_ques_res.startup_registration_id

						else
							render json: application_ques_res.errors , status: :unprocessable_entity
						end
					end

				end
				status = check_startups(startup_registration_id)
				if status
					render json: {message: "Reviews are completed"}, status: :ok
				else
					render json: {message: "Have pending reviews"}, status: :ok
				end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end

		private
		def check_startups(id)
			startup_registration = StartupRegistration.find(id)
			app_ques_res = startup_registration.app_ques_responses
			app_ques_res.each do |app_res|
				if app_res[:admin_response] == false
					program_status = ProgramStatus.find_by_status("RP")
					startup_registration.program_status_id = program_status.id
					startup_registration.application_status = program_status.status
					startup_registration.app_status_description = program_status.description
					startup_registration.score = app_ques_res.sum(:reviewer_rating)
					if startup_registration.save!
						return false
					end
				end
			end
			program_status = ProgramStatus.find_by_status("RC")
			startup_registration.program_status_id = program_status.id
			startup_registration.application_status = program_status.status
			startup_registration.app_status_description = program_status.description
			startup_registration.score = app_ques_res.sum(:reviewer_rating)
			if startup_registration.save!
				return true
			end
		end
		def application_question_params
		    params.require(:application_question).permit(:id,
		    									:title,
		    									:question,
		    									:description,
		    									:isActive,
		    									:program_id,
		    									:program_location_id,
		    									:placeholder
		    									 )
		end
		def app_ques_response_params
			params.require(:application_ques_response).permit(:id,:application_question_id,:response,
															  :reviewer_rating,:reviewer_feedback,
															  :program_location_id,:startup_registration_id,
															  :startup_response,:admin_response,:reviewed_by
																)
		end

	end
end	

#####program_registation_question params####

#title
#question
#description
#isActive, default: true
#isDelete, default: false
#deleted_by
#created_by
#deleted_date
#placeholder
#program_id
#created_at, null: false
#updated_at, null: false
#program_location_id


###########application question response#########
# t.integer "application_question_id"
#     t.text "response"
#     t.integer "reviewer_rating"
#     t.text "reviewer_feedback"
#     t.integer "program_location_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.integer "startup_registration_id"
#     t.boolean "startup_response", default: false
#     t.boolean "admin_response", default: false
#     t.integer "reviewed_by"