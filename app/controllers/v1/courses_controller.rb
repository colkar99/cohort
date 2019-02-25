module V1
	 class CoursesController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		
		def view_all_courses
			# module_grand_access = permission_control("course","show")
			module_grand_access = true
			if module_grand_access
				courses = Course.all
				if courses.present?
					render json: courses ,status: :ok
				else
					render json: {error: "No Courses are created"}, status: :not_found
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
		end
	 	def create_new_course
			# module_grand_access = permission_control("course","create")
			module_grand_access = true
			if module_grand_access
				if params[:course][:id].present?
					course_update = Course.find(params[:course][:id])
					if course_update.present?
						course_update.created_by = current_user.id
						if course_update.update!(course_params)
							render json: course_update, status: :ok
						else
							render json: course_update.errors,status: :bad_request
						end
					else
						render json: {error: "Course not found with this id"}
					end
				else
					course_create = Course.new(course_params)
					course_create.created_by = current_user.id
					if course_create.save!
						render json: course_create, status: :created
					else
						render json: course_create.errors,status: :bad_request
					end 
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
	 	end

	 	def create_activity
			# module_grand_access = permission_control("course","create")
			module_grand_access = true
			if module_grand_access
				Activity.transaction do
					course = Course.find(params[:course_id])
					if params[:activity][:id].present?
						activity_update = Activity.find(params[:activity][:id])
						activity_update.created_by = current_user.id
						if activity_update.update!(activity_params)
							link_course_and_activity = CoursesController.link_course_and_activity(course,activity_update)
							if link_course_and_activity
								params[:activity][:checklists].each do |checklist|
									if checklist[:id].present?
										checklist_update = CoursesController.checklist_update(checklist,activity_update,current_user.id)
										if checklist_update
											puts "Checklist updated successfully"
										else
	      									raise ActiveRecord::Rollback										
										end
									else
										checklist_create = CoursesController.checklist_create(checklist,activity_update,current_user.id)
										if checklist_create
											puts "checklists created successfully"
										else
											raise ActiveRecord::Rollback										
										end
									end
								end
								render json: course , status: :ok
							else
								raise ActiveRecord::Rollback										
							end
						else
							render json: activity_update.errors ,status: :bad_request
						end
					else
						activity_create = Activity.new(activity_params)
						activity_create.created_by = current_user.id

						if activity_create.save!
							link_course_and_activity = CoursesController.link_course_and_activity(course,activity_create)
							if link_course_and_activity
								params[:activity][:checklists].each do |checklist|
									if checklist[:id].present?
										checklist_update = CoursesController.checklist_update(checklist,activity_create,current_user.id)
										if checklist_update
											puts "Checklist updated successfully"
										else
	      									raise ActiveRecord::Rollback										
										end
									else
										checklist_create = CoursesController.checklist_create(checklist,activity_create,current_user.id)
										if checklist_create
											puts "checklists created successfully"
										else
											raise ActiveRecord::Rollback										
										end
									end
								end
								render json: course , status: :ok
							else
								raise ActiveRecord::Rollback										

							end
						else
							render json: activity_update.errors ,status: :bad_request
						end 
					end
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end	 		
	 	end

	 	def delete_course
	 		# module_grand_access = permission_control("course","delete")
			module_grand_access = true
			if module_grand_access
				Course.transaction do
					course = Course.find(params[:course_id])
					if course.present?
						activities = course.activities
						activities.each do |activity|
							checklists = activity.checklists
							if checklists.destroy_all
								course_activity_link_delete = CoursesController.course_activity_link_delete(course,activity)
								if course_activity_link_delete
									if activity.destroy
										course_framework_link_delete = CoursesController.course_framework_link_delete(course)
										if course_framework_link_delete
											puts "course_framework_link_deleted"
										else
											raise ActiveRecord::Rollback																	
										end
									else
										raise ActiveRecord::Rollback																	
									end
								else
									raise ActiveRecord::Rollback																	

								end
							else
								raise ActiveRecord::Rollback																	
							end
						end
						if course.destroy
							render json: {message: "Course and Related activity and checklists are deleted"}
						else
							raise ActiveRecord::Rollback																	
						end
					else
						render json: {error: "Course not found with this id"},status: :ok
					end  
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized								
			end
	 		
	 	end

	 	def self.course_framework_link_delete(course)
	 		framework_course_link = FrameworkCourseLink.where("course_id": course.id)
	 		if framework_course_link.present?
	 			framework_course_link.each do |delete_this|
	 				if delete_this.destroy
	 					true
	 				else
	 					false
	 				end
	 			end
	 		else
	 			true
	 		end
	 	end

	 	def self.course_activity_link_delete(course,activity)
	 		course_activity_link = CourseActivityLink.where("course_id": course.id,"activity_id": activity.id ).first
	 		if course_activity_link.present?
	 			if course_activity_link.destroy
	 				true
	 			else
	 				false
	 			end
	 		else
	 			true
	 		end
	 		
	 	end

	 	def delete_activity
	 		# module_grand_access = permission_control("activity","delete")
			module_grand_access = true
			if module_grand_access
				activity = Activity.find(params[:activity_id])
				if activity.present?
					Activity.transaction do
						checklists = activity.checklists
						if checklists.destroy_all
							puts "Checklists related to this activities are deleted"
							if activity.destroy
								course_activity_link = CourseActivityLink.where("course_id": params[:course_id],"activity_id": activity.id)
								if course_activity_link.destroy_all
									render json: {message: "Activity and related checklists are deleted successfully"},status: :ok
								else
									raise ActiveRecord::Rollback										
								end
							else
								raise ActiveRecord::Rollback										
							end
						else
							raise ActiveRecord::Rollback										
						end
					end
				else
					render json: {error: "Activity not found"},status: :bad_request
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized								
	 		end
	 	end

	 	def self.link_course_and_activity(course,activity)
	 		course_activity_link_available = CourseActivityLink.where("activity_id": activity.id,"course_id": course.id).first
	 		if course_activity_link_available.present?
	 			true
	 		else
		 		course_activity_link = CourseActivityLink.new
		 		course_activity_link.course_id = course.id
		 		course_activity_link.activity_id = activity.id
		 		if course_activity_link.save!
		 			true
		 		else
		 			false
		 		end	 			
	 		end
	 	end

	 	def self.checklist_update(checklist,activity,current_user_id)
	 		checklist_update = Checklist.find(checklist[:id])
			if checklist_update.present?
				checklist_update.name = checklist[:name]
				checklist_update.description = checklist[:description]
				checklist_update.created_by = current_user_id
				checklist_update.activity_id = activity.id
				if checklist_update.save!
					true
				else
					false
				end
			else
				false
			end	 		
	 	end

	 	def self.checklist_create(checklist,activity,current_user_id)
			checklist_create = Checklist.new
			checklist_create.name = checklist[:name]
			checklist_create.description = checklist[:description]
			checklist_create.created_by = current_user_id
			checklist_create.activity_id = activity.id
			if checklist_create.save!
				puts "Created"
				true
			else
				false										
			end
	 	end
	 
	 	# def assign_courses_to_startup
	 	# 	module_grand_access = permission_control("activity","update")
	 	# 	if module_grand_access
	 	# 		startup_profile = StartupProfile.find(params[:startup_profile_id])
	 	# 		if startup_profile.present?
	 	# 			courses = params[:courses]
	 	# 			courses.each do |course|
	 	# 				course = Course.find(course)
	 	# 				if course.present?
	 	# 					activities = course.activities
	 	# 					activities.each do |activity|

	 	# 					end
	 	# 				else
	 	# 					render json: {error: "Courses not found with this ID"},status: :bad_request
	 	# 				end
	 	# 			end
	 	# 		else
	 	# 			render json: {error: "Startup profile with this ID not present"},status: :bad_request
	 	# 		end
	 	# 	else
   # 			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 			
			# end
	 	# end

	 	# def self.create_activity_response(activity,startup_profile,course,target_date,program_id)
	 	# 	avtivity_create = ActivityResponse.new
	 	# 	avtivity_create.startup_profile_id = startup_profile.id
	 	# 	avtivity_create.activity_id = activity.id
	 	# 	avtivity_create.activity_id = activity.id


	 	# end
    # t.text "startup_response"
    # t.integer "startup_profile_id"
    # t.integer "activity_id"
    # t.integer "checklist_id"
    # t.boolean "checklist_status", default: false
    # t.integer "admin_rating"
    # t.text "admin_feedback"
    # t.integer "mentor_rating"
    # t.text "mentor_feedback"
    # t.integer "created_by"
    # t.boolean "isActive", default: true
    # t.boolean "isDelete", default: false
    # t.integer "deleted_by"
    # t.datetime "deleted_at"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.integer "admin_id"
    # t.integer "mentor_id"
    # t.integer "program_id"
    # t.string "target_date"
    # t.boolean "startup_responsed", default: false
    # t.integer "course_id"

 	    private
 	    def framework_params
		    params.require(:framework).permit(:id,:title,:description,:activity_name,:level,
		    									:main_image,:thumb_image,:url,:created_by,:isActive
		    									 )
 	    end
 	    def course_params
 	    	params.require(:course).permit(:id,
		    									:title,:description,:additional_description,:isActive,:created_by,:deleted_by
		    									 )
 	    end
 	    def activity_params
 	    	params.require(:activity).permit(:id,:name,:description,:order,:placeholder)
 	    end
 	    def checklist_params
 	    	params.require(:checklist).permit(:id,:name,:description,:activity_id) 	    	
 	    end

	 end
end


######current_state_form params########

# t.string "title"
# t.text "description"
# t.string "activity_name"
# t.integer "level", default: 0
# t.string "main_image"
# t.string "thumb_image"
# t.string "url"
# t.integer "created_by"
# t.boolean "isActive", default: true
# t.boolean "isDelete", default: false
# t.integer "deleted_by"
# t.datetime "deleted_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false


#####Activity############
# t.string "name"
# t.text "description"
# t.text "placeholder"
# t.integer "order"

####### checklist##########

   # t.string "name"
   #  t.text "description"
   #  t.integer "framework_id"
   #  t.integer "activity_id"
   #  t.integer "created_by"



