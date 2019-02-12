module V1
	 class MentorUsersController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:create]
	 	# before_action  :current_user, :get_module

	 	#used for mentor registration
	 	def self.create(user_id,data)
	 		mentor_user = MentorUser.new("user_id": user_id,
	 										"type_name": data[:type],
											"title": data[:title],
											"company": data[:company],
											"linked_in_url": data[:linked_in_url],
											"facebook_url": data[:facebook_url],
											"primary_expertise": data[:primary_expertise],
											"why_mentor": data[:why_mentor],
											"startup_experience": data[:startup_experience],
											"startup_experience_level": data[:startup_experience_level],
											"expertise_expanded": data[:expertise_expanded],
											"start_date": data[:start_date],
											"end_date": data[:end_date],
											"commitment": data[:commitment],
											"mentorship_type": data[:mentorship_type],
											"looking_for": data[:looking_for],
											"visibility": data[:visibility],
											"area_of_expertise": data[:area_of_expertise])
	 		if mentor_user.save!
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
# t.string "type"
# t.text "title"
# t.text "company"
# t.string "linked_in_url"
# t.string "facebook_url"
# t.text "primary_expertise"
# t.text "why_mentor"
# t.text "startup_experience"
# t.text "startup_experience_level"
# t.text "expertise_expanded"
# t.datetime "start_date"
# t.datetime "end_date"
# t.text "commitment"
# t.string "mentorship_type"
# t.text "looking_for"
# t.string "visibility"
# t.text "area_of_expertise"
# t.boolean "isActive"
# t.boolean "isDelete"
# t.integer "created_by"
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["user_id"], name: "index_mentor_users_on_user_id"