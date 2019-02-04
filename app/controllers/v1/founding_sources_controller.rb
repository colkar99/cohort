module V1
	 class FoundingSourcesController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		def create
			founding_source = FoundingSource.new(founding_sources_params)
			startup_auth = startup_auth_check(params[:founding_source][:startup_profile_id],current_user)
			if startup_auth
				if founding_source.save!
					startup_profile = StartupProfile.find(founding_source.startup_profile_id)
					founding_sources = startup_profile.founding_sources
					render json:  founding_sources , status: :created
				else
					render json: founding_source.errors, status: :unprocessable_entity
				end
			else
				render json: {error: "Your user id not matched with startup profile users"},status: :not_found
			end	
		end

		def edit
			founding_source = FoundingSource.find(params[:founding_source][:id])
			startup_auth = startup_auth_check(founding_source.startup_profile_id,current_user)
			if startup_auth
				if founding_source.update!(founding_sources_params)
					startup_profile = StartupProfile.find(params[:founding_source][:startup_profile_id])
					founding_sources = startup_profile.founding_sources
					render json: founding_sources , status: :ok
				else
					render json: founding_source.errors, status: :unprocessable_entity
				end
			else
				render json: {error: "Your user id not matched with startup profile users"},status: :not_found
			end	
			
		end

		def delete
			founding_source = FoundingSource.find(params[:founding_source][:id])
			startup_auth = startup_auth_check(founding_source.startup_profile_id,current_user)
			if startup_auth
				if founding_source.destroy
					# render json: founding_source , status: :ok
					startup_profile = StartupProfile.find(founding_source.startup_profile_id)
					founding_sources = startup_profile.founding_sources
					render json: founding_sources,status: :ok
				else
					render json: founding_source.errors, status: :unprocessable_entity
				end
			else
				render json: {error: "Your user id not matched with startup profile users"},status: :not_found
			end				
		end




 	    private
 	    def founding_sources_params
		    params.require(:founding_source).permit(:id,
		    									:source,
		    									:amount,
		    									:description,
		    									:date,
		    									:startup_profile_id
		    									 )
 	    end

	 end
end

##########Founding Source############33
    # t.text "source"
    # t.text "amount"
    # t.text "description"
    # t.datetime "date"
    # t.integer "startup_profile_id"

######activity params########

# t.string "name"
#     t.text "description"
#     t.text "placeholder"
#     t.integer "order"
#     t.integer "framework_id"
#     t.integer "created_by"
#     t.boolean "isActive", default: true
#     t.boolean "isDelete", default: false
#     t.integer "deleted_by"
#     t.datetime "deleted_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["framework_id"], name: "index_activities_on_framework_id"
	