module V1
	class ProgramsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = user_validate("create")
		 	@program_type = ProgramType.new(program_type_params)
		 	@program_type.created_by = current_user.id
		 	if module_grand_access
		 			if @program_type.save
			    	  	render json: @program_type ,status: :created 
					else
		      			render json: @program_type, status: :unprocessable_entity,
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
		    	ModuleType.find_by_name("program_type")
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

		def program_type_params
		    params.require(:program_type).permit(:id,
		    									:program_type_title,
		    									:program_type_description,
		    									:program_type_duration,
		    									:program_type_logo,
		    									:program_type_main_image,
		    									 :isDelete,
		    									 )
		end

	end
end	

#####program_type params####


	#program_type_title
	#program_type_description
	#program_type_duration
	#program_type_logo
	#program_type_main_image
	#created_at", null: false
	#updated_at, null: false
	#isDelete
	#deleted_by
	#deleted_date
	#created_by