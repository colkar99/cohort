module V1
	class ProgramsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = user_validate("create")
		 	@program = Program.new(program_params)
		 	@program.created_by = current_user.id
		 	if module_grand_access
		 			if @program.save
			    	  	render json: @program ,status: :created 
					else
		      			render json: @program, status: :unprocessable_entity,
		                       serializer: ActiveModel::Serializer::ErrorSerializer
					end 
		 	else
		 		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized

		 	end
		end
######
	 	def edit
		 	# binding.pry
		 	module_grand_access = user_validate("update")
		 	if module_grand_access
			 	@program = Program.find(params[:program][:id])
			 	if @program.update(program_params)
			 		render json: @program ,status: :created 
			 	else
			 		render json: @program, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
			@programs = Program.all
			render json: @programs ,status: :created
		end
		########
		def delete
			# binding.pry
		 	module_grand_access = user_validate("delete")
		 	if module_grand_access
			 	@program = Program.find(params[:program][:id])
			 	@program.isDelete = true
			 	@program.deleted_date = Time.now
			 	@program.deleted_by = current_user.id
			 	if @program.update(program_params)
			 		render json: @program ,status: :created 
			 	else
			 		render json: @program, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end
	#######This module used to get module type to give permission to specific module
	 	def get_module
		    	ModuleType.find_by_name("program")
		end
	#################	
	###########This method is used to validate user access
		def user_validate(data)
	    	if data == "create"
	    		current_user.user_roles.each do |user_role|
	    		# binding.pry
	    			if get_module.name == user_role.module_type.name
	    			# binding.pry
	    				return true if user_role.create_rule == true
	    			end
	    		end
	    	return false
	    	elsif data == "update"
	    		current_user.user_roles.each do |user_role|
	    		# binding.pry
	    			if get_module.name == user_role.module_type.name
	    			# binding.pry
	    				return true if user_role.update_rule == true
	    			end
	    		end
	    	return false
	    	elsif data == "delete"
	    		current_user.user_roles.each do |user_role|
	    		# binding.pry
	    			if get_module.name == user_role.module_type.name
	    			# binding.pry
	    				return true if user_role.delete_rule == true
	    			end
	    		end
	    		return false
	    	end	
	    end
	###########################
		private

		def program_params
		    params.require(:program).permit(:id,
		    									:program_type_id,
		    									:title,
		    									:description,
		    									:start_date,
		    									:end_date,
		    									 :program_admin_id,
		    									 :seat_size,
		    									 :ProgramLocation_id,
		    									 :industry,
		    									 :main_image,
		    									 :logo_image,
		    									 :duration,
		    									 :application_start_date,
		    									 :application_end_date
		    									 )
		end

	end
end	

#####program params####

#program_type_id
#title
#description
#start_date
#end_date
#program_admin_id
#seat_size
#ProgramLocation_id
#industry
#main_image
#logo_image
#duration
#application_start_date
#application_end_date
#created_by
#isDelete, default: false
#deleted_by
#deleted_date
#created_at, null: false
#updated_at, null: false
#isActive. default: true