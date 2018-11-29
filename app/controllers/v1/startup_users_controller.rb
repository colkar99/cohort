module V1
	 class StartupUsersController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create]
	 	# before_action  :current_user, :get_module

	 	def self.create(user_id,data)
	 		startup_user = StartupUser.new("user_id": user_id,
	 										"startup_profile_id": data[:startup_profile_id])
	 		if startup_user.save!
	 			true
	 		else
	 			false
	 		end								 
	 	end

	    private

	    def user_params
	    	params.require(:user).permit(:first_name,:full_name,:last_name, :email, :phone_number,
	    								:password, :password_confirmation,:user_main_image,
	   									:credentials,:commitment,:isDelete,:deleted_by,:deleted_date,:created_by,:id)
	    end
	 end
end

###### Startup -user params##########
# t.integer "user_id"
# t.integer "startup_profile_id"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["startup_profile_id"], name: "index_startup_users_on_startup_profile_id"
# t.index ["user_id"], name: "index_startup_users_on_user_id"
