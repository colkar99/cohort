module V1
	class StartupProfileQuestionsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = permission_control("startup_profile_question","create")
		 	@startup_profile_question = StartupProfileQuestion.new(startup_profile_question_params)
		 	@startup_profile_question.created_by = current_user.id
		 	if module_grand_access
		 			if @startup_profile_question.save
			    	  	render json: @startup_profile_question ,status: :created 
					else
		      			render json: @startup_profile_question, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
					end 
		 	else
		 		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized

		 	end
		end
######
	 	def edit
		 	binding.pry
		 	module_grand_access = permission_control("startup_profile_question","update")
		 	if module_grand_access
			 	@startup_profile_question = StartupProfileQuestion.find(params[:startup_profile_question][:id])
			 	if @startup_profile_question.update(startup_profile_question_params)
			 		render json: @startup_profile_question ,status: :ok 
			 	else
			 		render json: @startup_profile_question, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
			@startup_profile_question = StartupProfileQuestion.all
			render json: @startup_profile_question ,status: :ok
		end
		########
		def delete
			binding.pry
		 	module_grand_access = permission_control("startup_profile_question","delete")
		 	if module_grand_access
			 	@startup_profile_question = ProgramRegistrationQuestion.find(params[:startup_profile_question][:id])
			 	@startup_profile_question.isDelete = true
			 	@startup_profile_question.deleted_date = Time.now
			 	@startup_profile_question.deleted_by = current_user.id
			 	if @startup_profile_question.update(startup_profile_question_params)
			 		render json: @startup_profile_question ,status: :ok 
			 	else
			 		render json: @startup_profile_question, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end



		private

		def startup_profile_question_params
		    params.require(:startup_profile_question).permit(:id,
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

#####program_profile_question params####

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
