module V1
	class ProgramRegistrationQuestionsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = user_validate("create")
		 	@program_registation_question = ProgramRegistrationQuestion.new(program_registration_question_params)
		 	@program_registation_question.created_by = current_user.id
		 	if module_grand_access
		 			if @program_registation_question.save
			    	  	render json: @program_registation_question ,status: :created 
					else
		      			render json: @program_registation_question, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
					end 
		 	else
		 		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized

		 	end
		end
######
	 	def edit
		 	binding.pry
		 	module_grand_access = user_validate("update")
		 	if module_grand_access
			 	@program_type = ProgramType.find(params[:program_type][:id])
			 	if @program_type.update(program_type_params)
			 		render json: @program_type ,status: :created 
			 	else
			 		render json: @program_type, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
		
			@program_types = ProgramType.all
			render json: @program_types ,status: :created
		end
		########
		def delete
			binding.pry
		 	module_grand_access = user_validate("delete")
		 	if module_grand_access
			 	@program_type = ProgramType.find(params[:program_type][:id])
			 	@program_type.isDelete = true
			 	@program_type.deleted_date = Time.now
			 	@program_type.deleted_by = current_user.id
			 	if @program_type.update(program_type_params)
			 		render json: @program_type ,status: :created 
			 	else
			 		render json: @program_type, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end
	#######This module used to get module type to give permission to specific module
	 	def get_module
		    	ModuleType.find_by_name("program_registration_question")
		end
	#################	
	###########This method is used to validate user access
		def user_validate(data)
	    	if data == "create"
	    		current_user.user_roles.each do |user_role|
	    		binding.pry
	    			if get_module.name == user_role.module_type.name
	    			binding.pry
	    				return true if user_role.create_rule == true
	    			end
	    		end
	    	return false
	    	elsif data == "update"
	    		current_user.user_roles.each do |user_role|
	    		binding.pry
	    			if get_module.name == user_role.module_type.name
	    			binding.pry
	    				return true if user_role.update_rule == true
	    			end
	    		end
	    	return false
	    	elsif data == "delete"
	    		current_user.user_roles.each do |user_role|
	    		binding.pry
	    			if get_module.name == user_role.module_type.name
	    			binding.pry
	    				return true if user_role.delete_rule == true
	    			end
	    		end
	    		return false
	    	end	
	    end
	###########################
		private

		def program_registration_question_params
		    params.require(:program_registation_question).permit(:id,
		    									:title,
		    									:question,
		    									:description,
		    									:isActive,
		    									:program_id,
		    									:program_location_id
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