module V1
	class ProgramLocationsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = permission_control("program_location","create")
		 	program_location = ProgramLocation.new(program_location_params)
		 	program_location.created_by = current_user.id
		 	if module_grand_access
		 			if program_location.save
			    	  	render json: program_location ,status: :created 
					else
		      			render json: program_location.errors, status: :unprocessable_entity
					end 
		 	else
		 		render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

		 	end
		end
######
	 	def edit
		 	# binding.pry
		 	module_grand_access = permission_control("program_location","update")
		 	if module_grand_access
			 	program_location = ProgramLocation.find(params[:program_location][:id])
			 	if program_location.update(program_location_params)
			 		render json: program_location ,status: :ok 
			 	else
			 		render json: program_location.errors, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
			module_grand_access = permission_control("program_location","show")
			if module_grand_access
				program_locations = ProgramLocation.all
				render json: program_locations ,status: :ok
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end
		########
		def delete
			# binding.pry
		 	module_grand_access = permission_control("program_location","delete")
		 	if module_grand_access
			 	@program_location = ProgramLocation.find(params[:program_location][:id])
			 	# @program_location.isDelete = true
			 	# @program_location.delete_at = Time.now
			 	# @program_location.deleted_by = current_user.id
			 	if @program_location.destroy
			 		render json: @program_location ,status: :ok 
			 	else
			 		render json: @program_location.errors, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end
	
		private

		def program_location_params
		    params.require(:program_location).permit(:id,
		    									:address_line_1,
		    									:address_line_2,
		    									:city,
		    									:state_province_region,
		    									:zip_pincode_postalcode,
		    									:country,
		    									:geo_location,
		    									:created_by,
		    									:isDelete,
		    									:deleted_by,
		    									:delete_at
		    									 )
		end

	end
end	


######Program locations params#######
#address_line_1
#address_line_2
#city
#state_province_region
#zip_pincode_postalcode
#country
#geo_location
#created_by
#isDelete", default: false
#deleted_by
#delete_at
#created_at, null: false
#updated_at, null: false