module V1
	class ProgramsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = permission_control("program","create")
		 	if module_grand_access
		 		@program = Program.new(program_params)
		 		@program.created_by = current_user.id
		 			if @program.save
			    	  	render json: @program ,status: :created 
					else
		      			render json: @program.errors, status: :unprocessable_entity
					end 
		 	else
		 		render json: { error: "You dont have access to create program types,Please contact Site admin" }, status: :unauthorized

		 	end
		end
######
	 	def edit
		 	# binding.pry
		 	module_grand_access = permission_control("program","update")
		 	if module_grand_access
			 	@program = Program.find(params[:program][:id])
			 	if @program.update(program_params)
			 		render json: @program ,status: :ok 
			 	else
			 		render json: @program.errors, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
			module_grand_access = permission_control("program","show")
			if module_grand_access
				@programs = Program.all
				render json: @programs ,status: :ok
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end
		########
		def delete
			# binding.pry
		 	module_grand_access = permission_control("program","delete")
		 	if module_grand_access
			 	@program = Program.find(params[:program][:id])
			 	@program.isDelete = true
			 	@program.deleted_date = Time.now
			 	@program.deleted_by = current_user.id
			 	if @program.update(program_params)
			 		render json: @program ,status: :ok 
			 	else
			 		render json: @program.errors, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end
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
		    									 :application_end_date,
		    									 :framework_id
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
#t.integer "framework_id"