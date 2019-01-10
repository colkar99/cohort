module V1
	class ProgramsController < ApplicationController
	 	skip_before_action :authenticate_request, only: [:get_list_of_programs]

	 	def create
		 	module_grand_access = permission_control("program","create")
		 	if module_grand_access
		 		program = Program.new(program_params)
		 		program.created_by = current_user.id
		 			if program.save!
		 				application_questions = params[:application_questions]
		 				application_questions.each do |app_ques|
		 					link_of_program = LinkOfProgramQuestion.create!(
		 						program_id: program.id, application_question_id: app_ques[:id],
		 						program_location_id: program.ProgramLocation_id)
		 				end

			    	  	render json: program ,status: :created 
					else
		      			render json: program.errors, status: :unprocessable_entity
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
				programs= Program.all
				program_types = ProgramType.all
				program_locations = ProgramLocation.all
				render json: {programs: programs,program_types: program_types,
					program_locations: program_locations} ,status: :ok
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
		def get_data_for_program_module
			module_grand_access = permission_control("program","show")
			if module_grand_access
				program_types = ProgramType.all
				program_locations = ProgramLocation.all
				application_questions = ApplicationQuestion.all
				frameworks = Framework.all
				users = User.where("user_type": "site" )
				program_admin = []
				program_director = []
				application_manager = []
				contract_manager = []
				users.each do |user|
					user_roles = user.roles
					user_roles.each do |usrRole|
						# binding.pry
						if usrRole.name == "program_admin"
							program_admin.push(user)
						elsif usrRole.name == "program_director"
							program_director.push(user)
						elsif usrRole.name == "application_manager"
							application_manager.push(user)
						elsif usrRole.name == "contract_manager"
							contract_manager.push(user)
						end	
					end 
				end
				render json: {users:{program_admin: program_admin,program_director: program_director,
									application_manager: application_manager,contract_manager: contract_manager
									},
									program_types: program_types,program_locations: program_locations, frameworks: frameworks,application_questions: application_questions},
							status: :ok			
			else
				render json: { error: "You dont have access to perform this action,Please contact Site admin" }, status: :unauthorized

			end
		end

		def get_list_of_programs
			time_today = Time.now.strftime("%F")
			live = []
			exp = []
			programs = Program.all
			if programs.present?
				programs.each do |program|
					if (program.application_end_date >= time_today.to_s) && (program.start_date >= time_today.to_s)
						live.push(program)
					else
						exp.push(program)
					end
				end
				render json: {all_programs: {live: live,exp: exp}}, status: :ok
			else
				render json: {errors: "Programs not available"}
			end	

			
		end
		
		def contract_manager_programs
			module_grand_access = permission_control("program","show")
			if module_grand_access
				programs = Program.where("contract_manager": current_user.id)
				if programs
					render json: programs, status: :ok
				else
					render json: {error: "Oops program not found for your id"}, status: :not_found
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
		    									 :framework_id,
		    									 :site_admin,
		    									 :program_admin,
		    									 :program_director,
		    									 :application_manager,
		    									 :contract_manager
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
# t.integer "site_admin"
# t.integer "program_admin"
# t.integer "program_director"
# t.integer "application_manager"
# t.integer "contract_manager"