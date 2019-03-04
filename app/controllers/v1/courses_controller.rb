module V1
	 class CoursesController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:get_assigned_courses_for_startup,:startup_response_for_activity]
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

	 	def create_checklists
	 		# module_grand_access = permission_control("course","delete")
			module_grand_access = true
			result = ""
			if module_grand_access
				Checklist.transaction do
					course = Course.find(params[:course_id])
					if params[:checklist][:id].present?
						# checklist = Checklist.find(params[:checklist][:id])
						checklist_update = CoursesController.checklist_update(params[:checklist],course,current_user.id)
						if checklist_update
							puts "Checklist updated successfully"
							result =  "Checklist updated successfully"
						else
							raise ActiveRecord::Rollback										
						end
					else
						checklist_create = CoursesController.checklist_create(params[:checklist],course,current_user.id)
						if checklist_create
							puts "checklists created successfully"
							result = "checklists created successfully"
						else
							raise ActiveRecord::Rollback										
						end
					end
					render json: course,status: :ok
				end
			else
				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end	 			 		
	 	end

	 	def delete_checklist
	 		# module_grand_access = permission_control("activity","delete")
			module_grand_access = true
			if module_grand_access
				checklist = Checklist.find(params[:checklist_id])
				if checklist.present?
					Checklist.transaction do
						if checklist.destroy
							render json: {message: "Checklist deleted successfully"},status: :ok
						else
							raise ActiveRecord::Rollback										
						end	
					end
				else
					render json: {error: "Checklist not found"},status: :bad_request
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
						end
						if course.destroy
							render json: {message: "Course and Related activity and checklists are deleted"},status: :ok
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
						if activity.destroy
							course_activity_link = CourseActivityLink.where("course_id": params[:course_id],"activity_id": activity.id)
							if course_activity_link.destroy_all
								render json: {message: "Activity deleted successfully"},status: :ok
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

	 	def self.checklist_update(checklist,course,current_user_id)
	 		checklist_update = Checklist.find(checklist[:id])
			if checklist_update.present?
				checklist_update.name = checklist[:name]
				checklist_update.description = checklist[:description]
				checklist_update.created_by = current_user_id
				checklist_update.course_id = course.id
				if checklist_update.save!
					true
				else
					false
				end
			else
				false
			end	 		
	 	end

	 	def self.checklist_create(checklist,course,current_user_id)
			checklist_create = Checklist.new
			checklist_create.name = checklist[:name]
			checklist_create.description = checklist[:description]
			checklist_create.created_by = current_user_id
			checklist_create.course_id = course.id
			if checklist_create.save!
				puts "Created"
				true
			else
				false										
			end
	 	end
	 
	 	def assign_activity_to_startups
	 		module_grand_access = permission_control("activity","update")
	 		activity_status = false
	 		checklist_status = false
	 		if module_grand_access
	 			ActivityResponse.transaction do
	 				program = Program.find(params[:program_id])
	 				startup_profile = StartupProfile.find(params[:startup_profile_id])
	 				if program.present? && startup_profile.present?
	 					courses = params[:courses]
	 					courses.each do |course|
	 						activities = course[:activities]
	 						activities.each do |activity|
	 							activity_response = ActivityResponse.where(startup_profile_id: startup_profile.id,activity_id: activity[:id],course_id: course[:id]).first
	 							if activity_response.present?
	 								activity_response.target_date = course[:target_date]
	 								activity_response.save!
	 								puts "This activity already assigned to startup"
	 								activity_status = true
	 							else
	 								activity_status = CoursesController.create_activity_response(course,activity,startup_profile,program)
	 							end
	 						end
							checklists = course[:checklists]
 							checklists.each do |checklist|
	 							checklist_response = ChecklistResponse.where(startup_profile_id: startup_profile.id,checklist_id: checklist[:id],course_id: course[:id]).first
	 							if checklist_response.present?
	 								puts "This checklist already assigned to startup"
	 								checklist_status = true
	 							else
	 								checklist_status = CoursesController.create_checklist_response(checklist,course,startup_profile,program)
	 							end
 							end
	 					end
	 					if activity_status && checklist_status
	 						startup_application = startup_profile.startup_registration
	 						if startup_application.application_status != "VDC"
	 							status = ProgramStatus.find_by_status("VDC")
	 							update_status = CoursesController.status_update(status,startup_application)
	 							if update_status
	 								# render json: {message: "Courses maped to startups"},status: :ok
	 								puts "Status updated in statup applications"
	 							else
	 								raise ActiveRecord::Rollback										
	 								render json: {error: "Something happened"},status: :bad_request
	 							end
	 						end
	 						mailer_courses = CoursesController.get_assigned_course_internal(startup_profile.id)
	 						VentureMailer.assign_activities_mail(startup_application,mailer_courses,program).deliver_later
	 						render json: {message: "Courses maped to startups"},status: :ok
	 					else
	 						raise ActiveRecord::Rollback										
	 						render json: {error: "Something happened"},status: :bad_request
	 					end
	 				else
	 					render json: {error: "Program or StartupProfile not found this ID"},status: :bad_request
	 				end
	 			end
	 		else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 			
	 		end
	 	end

	 	def self.status_update(status,startup_application)
	 		if status.present?  &&  startup_application.present?
	 			startup_application.program_status_id = status.id
	 			startup_application.application_status = status.status
	 			startup_application.app_status_description = status.description
	 			if startup_application.save!
	 				true
	 			else
	 				false
	 			end
	 		else
	 			false
	 		end
	 	end

	 	def self.create_checklist_response(checklist,course,startup_profile,program)
	 		checklist_response = ChecklistResponse.new
	 		checklist_response.checklist_id = checklist[:id]
	 		checklist_response.course_id = course[:id]
	 		checklist_response.program_id = program[:id]
	 		checklist_response.startup_profile_id = startup_profile[:id]
	 		if checklist_response.save!

	 			true
	 		else
	 			raise ActiveRecord::Rollback										
	 			false
	 		end
	 	end
	 	def self.create_activity_response(course,activity,startup_profile,program)
	 		activity_response = ActivityResponse.new
	 		activity_response.activity_id = activity[:id]
	 		activity_response.course_id = course[:id]
	 		activity_response.program_id = program[:id]
	 		activity_response.startup_profile_id = startup_profile[:id]
	 		activity_response.target_date = course[:target_date]
	 		# activity_response.startup_response = ""
	 		# activity_response.created_by = current_user.id
	 		if activity_response.save!
	 			true
	 		else
	 			raise ActiveRecord::Rollback										
	 			false
	 		end
	 	end

	 	def self.get_assigned_course_internal(startup_profile_id)
	 			selected_courses = []
	 			startup_profile = StartupProfile.find(startup_profile_id)
	 			fetch_target_date = ""
	 			courses = Course.all
	 			courses.each do |course|
	 				is_activity_response_available = false
	 				activities = course.activities
	 				activities.each do |activity|
	 					activity_responses = ActivityResponse.where(startup_profile_id: startup_profile.id,activity_id: activity.id).first
	 					if activity_responses.present?
	 						activity.startup_response = activity_responses.startup_response
	 						activity.startup_responsed = activity_responses.startup_responsed
	 						activity.admin_responsed = activity_responses.admin_responsed
	 						activity.mentor_responsed = activity_responses.mentor_responsed
	 						activity.admin_feedback = activity_responses.admin_feedback
	 						is_activity_response_available = true
	 						fetch_target_date = activity_responses.target_date

	 					else
	 						activity.startup_response = ""
	 						activity.startup_responsed = false
	 						activity.admin_responsed = false
	 						activity.mentor_responsed = false
	 					end
	 				end
	 				checklists = course.checklists
 					checklists.each do |checklist|
 						checklists_responses = ChecklistResponse.where(checklist_id: checklist.id,startup_profile_id: startup_profile.id, course_id: course.id).first
 						if checklists_responses.present?
 							checklist.admin_responsed = checklists_responses.admin_responsed
 							checklist.admin_feedback = checklists_responses.admin_feedback
 							checklist.mentor_feedback = checklists_responses.mentor_feedback
 							checklist.mentor_responsed = checklists_responses.mentor_responsed
 							checklist.is_passed = checklists_responses.is_passed
 						else
 							checklist.admin_responsed = false
 							checklist.mentor_responsed = false
 						end
 					end
	 				course.is_assigned = is_activity_response_available
	 				course.target_date = fetch_target_date

	 			end
	 			courses.each do |course|
	 				if course.is_assigned
	 					selected_courses.push(course)
	 				end
	 			end
	 			selected_courses
	 	
	 	end
# :startup_response,:startup_responsed,:admin_responsed,:mentor_responsed
	 	def get_assigned_courses
	 		module_grand_access = true
	 		if module_grand_access
	 			startup_profile = StartupProfile.find(params[:startup_profile_id])
	 			fetch_target_date = ""
	 			courses = Course.all
	 			courses.each do |course|
	 				is_activity_response_available = false
	 				activities = course.activities
	 				activities.each do |activity|
	 					activity_responses = ActivityResponse.where(startup_profile_id: startup_profile.id,activity_id: activity.id).first
	 					if activity_responses.present?
	 						activity.startup_response = activity_responses.startup_response
	 						activity.startup_responsed = activity_responses.startup_responsed
	 						activity.admin_responsed = activity_responses.admin_responsed
	 						activity.mentor_responsed = activity_responses.mentor_responsed
	 						activity.admin_feedback = activity_responses.admin_feedback
	 						is_activity_response_available = true
	 						fetch_target_date = activity_responses.target_date
	 					else
	 						activity.startup_response = ""
	 						activity.startup_responsed = false
	 						activity.admin_responsed = false
	 						activity.mentor_responsed = false
	 					end
	 				end
	 				checklists = course.checklists
 					checklists.each do |checklist|
 						checklists_responses = ChecklistResponse.where(checklist_id: checklist.id,startup_profile_id: startup_profile.id, course_id: course.id).first
 						if checklists_responses.present?
 							checklist.admin_responsed = checklists_responses.admin_responsed
 							checklist.admin_feedback = checklists_responses.admin_feedback
 							checklist.mentor_feedback = checklists_responses.mentor_feedback
 							checklist.mentor_responsed = checklists_responses.mentor_responsed
 							checklist.is_passed = checklists_responses.is_passed
 						else
 							checklist.admin_responsed = false
 							checklist.mentor_responsed = false
 						end
 					end
	 				course.is_assigned = is_activity_response_available
	 				course.target_date = fetch_target_date
	 			end
	 			render json: courses,status: :ok
	 		else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 				 			
	 		end
	 	end

	 	def get_assigned_courses_for_startup
	 		module_grand_access = true
	 		selected_courses = []
	 		if module_grand_access
	 			startup_profile = StartupProfile.find(params[:startup_profile_id])
	 			fetch_target_date = ""
	 			courses = Course.all
	 			courses.each do |course|
	 				is_activity_response_available = false
	 				activities = course.activities
	 				activities.each do |activity|
	 					activity_responses = ActivityResponse.where(startup_profile_id: startup_profile.id,activity_id: activity.id).first
	 					if activity_responses.present?
	 						activity.startup_response = activity_responses.startup_response
	 						activity.startup_responsed = activity_responses.startup_responsed
	 						activity.admin_responsed = activity_responses.admin_responsed
	 						activity.mentor_responsed = activity_responses.mentor_responsed
	 						activity.admin_feedback = activity_responses.admin_feedback
	 						is_activity_response_available = true
	 						fetch_target_date = activity_responses.target_date

	 					else
	 						activity.startup_response = ""
	 						activity.startup_responsed = false
	 						activity.admin_responsed = false
	 						activity.mentor_responsed = false
	 					end
	 				end
	 				checklists = course.checklists
 					checklists.each do |checklist|
 						checklists_responses = ChecklistResponse.where(checklist_id: checklist.id,startup_profile_id: startup_profile.id, course_id: course.id).first
 						if checklists_responses.present?
 							checklist.admin_responsed = checklists_responses.admin_responsed
 							checklist.admin_feedback = checklists_responses.admin_feedback
 							checklist.mentor_feedback = checklists_responses.mentor_feedback
 							checklist.mentor_responsed = checklists_responses.mentor_responsed
 							checklist.is_passed = checklists_responses.is_passed
 						else
 							checklist.admin_responsed = false
 							checklist.mentor_responsed = false
 						end
 					end
	 				course.is_assigned = is_activity_response_available
	 				course.target_date = fetch_target_date

	 			end
	 			courses.each do |course|
	 				if course.is_assigned
	 					selected_courses.push(course)
	 				end
	 			end
	 			render json: selected_courses,status: :ok
	 		else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 				 			
	 		end
	 	end

	 	def startup_response_for_activity
	 		ActivityResponse.transaction do
	 			startup_profile = StartupProfile.find(params[:startup_profile_id])
		 		activity_response = ActivityResponse.where(activity_id: params[:activity_id],startup_profile_id: params[:startup_profile_id],course_id: params[:course_id]).first
		 		if activity_response.present?
		 			activity_response.startup_response = params[:startup_response]
		 			activity_response.startup_responsed = true
		 			if activity_response.save!
		 				# render json: activity_response,status: :ok
		 				puts "Activity responses updated"
		 			else
		 				raise ActiveRecord::Rollback										
		 				render json: activity_response.errors,status: :bad_request
		 			end
		 		else
		 			create_activity_response = ActivityResponse.new
		 			create_activity_response.startup_profile_id = startup_profile.id
		 			create_activity_response.activity_id = params[:activity_id]
		 			create_activity_response.course_id = params[:course_id]
		 			create_activity_response.startup_response = params[:startup_response]
		 			create_activity_response.startup_responsed = true
		 			if create_activity_response.save!
		 				puts "New Activity responses created"
		 			else
		 				raise ActiveRecord::Rollback										
		 				render json: create_activity_response.errors,status: :bad_request
		 			end
				end
				render json: {message: "Startup response successfully received"},status: :ok
	 		end
	 	end

	 	def admin_response_for_activity
	 		module_grand_access = permission_control("activity","update")
	 		if module_grand_access
	 			ActivityResponse.transaction do
	 				startup_profile = StartupProfile.find(params[:startup_profile_id])
			 		activity_response = ActivityResponse.where(activity_id: params[:activity_id],startup_profile_id: params[:startup_profile_id],course_id: params[:course_id]).first
			 		if activity_response.present?
			 			activity_response.admin_responsed = true
			 			activity_response.admin_feedback = params[:admin_feedback]
			 			if activity_response.save!
			 				render json: activity_response,status: :ok
			 			else
			 				raise ActiveRecord::Rollback										
			 				render json: activity_response.errors,status: :bad_request
			 			end
			 		else
			 			raise ActiveRecord::Rollback										
			 			render json: {error: "Activity response not present with this ID"},status: :bad_request
					end
	 			end
	 		else
   				render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized			 				 			
	 		end
	 	end

	 	def checklists_response_by_admin
	 		module_grand_access = permission_control("activity","update")
	 		if module_grand_access
	 			ChecklistResponse.transaction do
	 				startup_profile = StartupProfile.find(params[:startup_profile_id])
			 		checklists = params[:checklists]
			 		checklists.each do |checklist|
			 			checklist_response = ChecklistResponse.where(startup_profile_id: startup_profile.id,course_id: params[:course_id],checklist_id: checklist[:id]).first
			 			if checklist_response.present?
			 				checklist_response.admin_responsed = true
			 				checklist_response.is_passed = checklist[:is_passed]
			 				if	checklist_response.save!
			 					puts "Checklists are updated"
			 				else
			 					raise ActiveRecord::Rollback										
			 					render json: checklist_response.errors,status: :bad_request
			 				end
			 			else
			 				create_checklist_response = ChecklistResponse.new
			 				create_checklist_response.startup_profile_id = params[:startup_profile_id]
			 				create_checklist_response.course_id = params[:course_id]
			 				create_checklist_response.checklist_id = checklist[:id]
			 				create_checklist_response.admin_responsed = true
			 				create_checklist_response.is_passed = checklist[:is_passed]
			 				if create_checklist_response.save!
			 					puts "New checklists created"
			 				else
			 					raise ActiveRecord::Rollback										
			 					render json: create_checklist_response.errors,status: :bad_request
			 				end
			 			end
			 		end
			 		render json: {message: "admin response successfully submitted"},status: :ok
	 			end
	 		else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 				 				 			
	 		end
	 	end

	 	def send_reminder_to_complete_activities
	 		module_grand_access = permission_control("activity","update")
	 		if module_grand_access
	 			courses = CoursesController.get_assigned_course_internal(params[:startup_profile_id])
	 			course = []
	 			courses.each do |course_current|
	 				if (course_current[:id] == params[:course_id])
	 					course.push(course_current)
	 				end
	 			end
	 			startup_profile = StartupProfile.find(params[:startup_profile_id])
	 			if course.present? && startup_profile.present?
	 				program = startup_profile.startup_registration.program
	 				program_admin = User.find(program.program_admin)
	 				current_user_logged = current_user
    				program_dir =  User.find(program.program_director)
	 				startup_user = startup_profile.users.first
	 				VentureMailer.send_courses_reminder(course,startup_user,program_dir,program_admin,program,startup_profile).deliver_later
	 				render json: {message: "reminder posted successfully"},status: :ok
	 			else
	 				render json: {error: "Course or startup Profile not found"},status: :bad_request
	 			end
	 		else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized	 		 			
			end
	 	end

 	    private
 	    def framework_params
		    params.require(:framework).permit(:id,:title,:description,:activity_name,:level,
		    									:main_image,:thumb_image,:url,:created_by,:isActive
		    									 )
 	    end
 	    def course_params
 	    	params.require(:course).permit(:id,:pass_metric,
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



###########Checklist responses##########3
    # t.integer "activity_id"
    # t.integer "course_id"
    # t.integer "program_id"
    # t.integer "startup_profile_id"
    # t.text "admin_feedback"
    # t.boolean "admin_responsed", default: false
    # t.text "mentor_feedback"
    # t.boolean "mentor_responsed", default: false
    # t.boolean "is_passed", default: false
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.index ["activity_id"], name: "index_checklist_responses_on_activity_id"
    # t.index ["course_id"], name: "index_checklist_responses_on_course_id"
    # t.index ["program_id"], name: "index_checklist_responses_on_program_id"
    # t.index ["startup_profile_id"], name: "index_checklist_responses_on_startup_profile_id"

    ###########Activity responses###############33
    # t.text "startup_response"
    # t.integer "startup_profile_id"
    # t.integer "activity_id"
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
    # t.boolean "admin_responsed", default: false
    # t.boolean "mentor_responsed", default: false


    				# 			params[:activity][:checklists].each do |checklist|
								# 	if checklist[:id].present?
								# 		checklist_update = CoursesController.checklist_update(checklist,activity_update,current_user.id)
								# 		if checklist_update
								# 			puts "Checklist updated successfully"
								# 		else
	      	# 								raise ActiveRecord::Rollback										
								# 		end
								# 	else
								# 		checklist_create = CoursesController.checklist_create(checklist,activity_update,current_user.id)
								# 		if checklist_create
								# 			puts "checklists created successfully"
								# 		else
								# 			raise ActiveRecord::Rollback										
								# 		end
								# 	end
								# end

								# params[:activity][:checklists].each do |checklist|
								# 	if checklist[:id].present?
								# 		checklist_update = CoursesController.checklist_update(checklist,activity_create,current_user.id)
								# 		if checklist_update
								# 			puts "Checklist updated successfully"
								# 		else
	      	# 								raise ActiveRecord::Rollback										
								# 		end
								# 	else
								# 		checklist_create = CoursesController.checklist_create(checklist,activity_create,current_user.id)
								# 		if checklist_create
								# 			puts "checklists created successfully"
								# 		else
								# 			raise ActiveRecord::Rollback										
								# 		end
								# 	end
								# end