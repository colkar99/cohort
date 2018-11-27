module V1
	 class ChecklistsController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def create
			binding.pry
			module_grand_access = permission_control("checklist","create")
			if module_grand_access
				checklist = Checklist.new(checklist_params)
				checklist.created_by = current_user.id
				if checklist.save!
					render json: checklist ,status: :created
				else
					render json: checklist, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end
		end

		def show_all
			checklist = Checklist.all.where("isDelete": false,"isActive":true)
			render json: checklist, status: :ok
			
		end

		def show
			activities = Activity.find(params[:activity_id]).checklists.where("isDelete": false)
			render json: activities, status: :ok
			
		end

		def edit
			module_grand_access = permission_control("checklist","update")
			if module_grand_access
				checklist = Checklist.find(params[:checklist][:id])
				# framework.created_by = current_user.id
				if checklist.update!(checklist_params)
					render json: checklist ,status: :ok
				else
					render json: checklist, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

			
		end

		

		def delete
			module_grand_access = permission_control("checklist","delete")
			if module_grand_access
				checklist = Checklist.find(params[:checklist][:id])
				# framework.created_by = current_user.id
				checklist.isActive = false
				checklist.isDelete = true
				checklist.deleted_at = Time.now
				checklist.deleted_by = current_user.id
				if checklist.update!(checklist_params)
					render json: checklist ,status: :ok
				else
					render json: checklist, status: :unprocessable_entity
		                       
				end
			else
				render json: {error: "Invalid Authorization"}, status: :unauthorized
			end

		end



 	    private
 	    def checklist_params
		    params.require(:checklist).permit(:id,
		    									:name,
		    									:description,
		    									:framework_id,
		    									:activity_id,
		    									:created_by,
		    									:isActive,
		    									:deleted_by
		    									 )
 	    end

	 end
end


######checklist params########
# t.string "name"
# t.text "description"
# t.integer "framework_id"
# t.integer "activity_id"
# t.integer "created_by"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["activity_id"], name: "index_checklists_on_activity_id"
# t.index ["framework_id"], name: "index_checklists_on_framework_id"