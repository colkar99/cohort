module V1
	class ProgramTypesController < ApplicationController
	 	
	 	def create
		 	module_grand_access = permission_control("program_type","create")
		 	program_type = ProgramType.new(program_type_params)
		 	program_type.created_by = current_user.id
		 	if module_grand_access
		 			if program_type.save!
			    	  	render json: program_type ,status: :created 
					else
		      			render json: program_type.errors, status: :unprocessable_entity
					end 
		 	else
		 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

		 	end
		end
######
	 	def edit
		 	# binding.pry
		 	module_grand_access = permission_control("program_type","update")
		 	if module_grand_access
			 	program_type = ProgramType.find(params[:program_type][:id])
			 	if program_type.update(program_type_params)
			 		render json: program_type ,status: :ok 
			 	else
			 		render json: program_type, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
			module_grand_access = permission_control("program_type","show")
			if module_grand_access
				@program_types = ProgramType.all
			render json: @program_types ,status: :ok
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end
		########
		def delete
			# binding.pry
		 	module_grand_access = permission_control("program_type","delete")
		 	if module_grand_access
			 	program_type = ProgramType.find(params[:program_type][:id])
			 	# program_type.isDelete = true
			 	# program_type.deleted_date = Time.now
			 	# program_type.deleted_by = current_user.id
			 	if program_type.delete!
			 		render json: program_type ,status: :ok 
			 	else
			 		render json: program_type.errors, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end
	
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