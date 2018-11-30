module V1
	class ProgramLocationsController < ApplicationController
	 	
	 	def create
		 	module_grand_access = user_validate("create")
		 	@program_location = ProgramLocation.new(program_location_params)
		 	@program_location.created_by = current_user.id
		 	if module_grand_access
		 			if @program_location.save
			    	  	render json: @program_location ,status: :created 
					else
		      			render json: @program_location, status: :unprocessable_entity,
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
			 	@program_location = ProgramLocation.find(params[:program_location][:id])
			 	if @program_location.update(program_location_params)
			 		render json: @program_location ,status: :created 
			 	else
			 		render json: @program_location, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
	 	end
########
		def show
		
			@program_locations = ProgramLocation.all
			render json: @program_locations ,status: :created
		end
		########
		def delete
			# binding.pry
		 	module_grand_access = user_validate("delete")
		 	if module_grand_access
			 	@program_location = ProgramLocation.find(params[:program_location][:id])
			 	@program_location.isDelete = true
			 	@program_location.delete_at = Time.now
			 	@program_location.deleted_by = current_user.id
			 	if @program_location.update(program_location_params)
			 		render json: @program_location ,status: :created 
			 	else
			 		render json: @program_location, status: :unprocessable_entity
			 	end
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end 	
		end
	#######This module used to get module type to give permission to specific module
	 	def get_module
		    	ModuleType.find_by_name("program_location")
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