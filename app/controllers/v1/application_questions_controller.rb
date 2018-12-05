module V1
	class ApplicationQuestionsController < ApplicationController
	 	
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
	
		private

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