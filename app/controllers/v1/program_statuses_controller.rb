module V1
	 class ProgramStatusesController < ApplicationController
	 	# skip_before_action :authenticate_request
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			module_grand_access = permission_control("program_status","create")
			if module_grand_access
				program_status = ProgramStatus.new(program_status_params)
				if program_status.save
					render json: program_status ,status: :created
				else
					render json: program_status, status: :unprocessable_entity,
	                       serializer: ActiveModel::Serializer::ErrorSerializer
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized

			end

		end

		def show
			program_statuses = ProgramStatus.all
			render json: program_statuses ,status: :ok
		end

		def edit
			module_grand_access = permission_control("program_status","update")
			if module_grand_access
				program_status = ProgramStatus.find(params[:program_status][:id])
				if program_status.update(program_status_params)
					render json: program_status ,status: :ok
				else
					render json: program_status, status: :unprocessable_entity,
	                       serializer: ActiveModel::Serializer::ErrorSerializer
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
			end
		end

		def delete
			module_grand_access = permission_control("program_status","delete")
			if module_grand_access
				program_status = ProgramStatus.find(params[:program_status][:id])
				program_status.isDelete = true
				program_status.deleted_by = current_user.id
				program_status.deleted_at = Time.now
				if program_status.update(program_status_params)
					render json: program_status ,status: :ok
				else
					render json: program_status, status: :unprocessable_entity,
	                       serializer: ActiveModel::Serializer::ErrorSerializer
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized
			end

		end


 	    private
 	    def program_status_params
		    params.require(:program_status).permit(:id,
		    									:status,
		    									:description,
		    									:isActive
		    									 )
 	    end

	 end
end


######Startup status params########

#t.string "status"
#t.text "description"
#t.datetime "created_at", null: false
#t.datetime "updated_at", null: false
    # t.string "created_by"
    # t.boolean "isDelete", default: false
    # t.boolean "isActive", default: true
    # t.datetime "deleted_at"
    # t.string "deleted_by"