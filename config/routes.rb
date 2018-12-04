Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	scope module: :v1 do
		post 'v1/authenticate', to: 'authentication#authenticate'
		post 'v1/user/registration', to: 'users#create'
		post 'v1/users/show-all', to: 'users#show_user_by_type'
		put 'v1/user/edit', to: 'users#edit'
		post 'v1/user/direct/registration', to: 'users#direct_registration'
		put 'v1/user/delete-user', to: 'users#delete'
		get 'v1/user-roles', to: 'user_roles#index'
		post 'v1/create-user-role', to: 'user_roles#create'
		post 'v1/edit-user-role', to: 'user_roles#edit'
		post 'v1/delete-user-role', to: 'user_roles#delete'
		post 'v1/create-program-type', to: 'program_types#create'
		put 'v1/edit-program-type', to: 'program_types#edit'
		get 'v1/show-program-types', to: 'program_types#show'
		post 'v1/delete-program-type', to: 'program_types#delete'
		###################
		#######startup user registration#########
		post 'v1/user/startup/registration' ,to: 'users#startup_user'
		#########################################
		#######mentor user registration#########
		post 'v1/user/mentor/registration' ,to: 'users#mentor_user'
		#########################################
		#######Grant permission#########
		post 'v1/user/admin-permissions' , to: 'user_roles#grant_access'
		################################
		#########role ##############
		post 'v1/create-role', to: 'roles#create'
		get 'v1/role/show-all', to: 'roles#show_all'
		put 'v1/role/edit', to: 'roles#edit'
		put 'v1/role/delete', to: 'roles#delete'

		############################

		####Program Location######
		post 'v1/create-program-location', to: 'program_locations#create'
		put 'v1/edit-program-location', to: 'program_locations#edit'
		get 'v1/show-program-locations', to: 'program_locations#show'
		post 'v1/delete-program-location', to: 'program_locations#delete'
		###############
		####Program ######
		post 'v1/create-program', to: 'programs#create'
		put 'v1/edit-program', to: 'programs#edit'
		get 'v1/show-programs', to: 'programs#show'
		post 'v1/delete-program', to: 'programs#delete'

		####Program Registration Questions######
		post 'v1/create-application-question', to: 'application_questions#create'
		put 'v1/edit-application-question', to: 'application_questions#edit'
		get 'v1/show-application-questions', to: 'application_questions#show'
		post 'v1/delete-application-question', to: 'application_questions#delete'
		###############
		####startup Registration Questions######
		post 'v1/create-startup-profile-question', to: 'startup_profile_questions#create'
		put 'v1/edit-startup-profile-question', to: 'startup_profile_questions#edit'
		get 'v1/show-startup-profile-questions', to: 'startup_profile_questions#show'
		post 'v1/delete-startup-profile-question', to: 'startup_profile_questions#delete'
		###############
		###############Startup_registration - program-registration#######
		post 'v1/program/startup-registration', to: 'startup_registrations#create'
		post 'v1/program/startup-application-details', to: 'startup_registrations#show_all_details'
		post 'v1/program/startup-app-response', to: 'startup_registrations#app_ques_res'
		post 'v1/program/admin/startup-app-response', to: 'startup_registrations#app_ques_res_admin'
		post 'v1/program/admin/startup-application-status-change' ,to: 'startup_registrations#set_app_status'
		get 'v1/program/admin/startup-application-accept-list' ,to: 'startup_registrations#show_accept_startup'
		#################################################################

		####################Contract form creation#######################
		post 'v1/program/startup/create-contract', to: 'contract_forms#create'
		##################################################################

		######startup profile ###########
		post 'v1/startup/direct-registration', to: 'startup_profiles#direct_registration'
		post 'v1/startup/authentication', to: 'startup_profiles#startup_authenticate'
		get 'v1/startup/show-profile', to: 'startup_profiles#show'
		get 'v1/startup/show-startup-profiles', to: 'startup_profiles#show_all'
		put 'v1/startup/edit-startup-profile', to: 'startup_profiles#edit'
		put 'v1/user/startup/edit-startup-profile', to: 'startup_profiles#admin_edit'
		post 'v1/startup/delete-startup-profile', to: 'startup_profiles#delete'
		post 'v1/user/startup/delete-startup-profile', to: 'startup_profiles#user_delete'
		#################################

		################program status########
		post 'v1/create-status', to: 'program_statuses#create'
		get 'v1/show-statuses', to: 'program_statuses#show'
		put 'v1/edit-status', to: 'program_statuses#edit'
		post 'v1/delete-status', to: 'program_statuses#delete'
		######################################

		################startup registration########
		# post 'v1/program/registration', to: 'startup_registrations#create'
		# get 'v1/show-statuses', to: 'program_statuses#show'
		# put 'v1/edit-status', to: 'program_statuses#edit'
		# post 'v1/delete-status', to: 'program_statuses#delete'
		######################################

		################current state form########
		post 'v1/program/create-current-state-form', to: 'current_state_forms#create'
		post 'v1/program/show-current-state-form', to: 'current_state_forms#show'
		post 'v1/program/user/show-current-state-form', to: 'current_state_forms#admin_show'
		put 'v1/program/edit-current-state-form', to: 'current_state_forms#edit'
		put 'v1/program/user/edit-current-state-form', to: 'current_state_forms#admin_edit'
		# post 'v1/delete-status', to: 'program_statuses#delete'
		######################################
		###########road map#############
		post 'v1/program/startup/create-road-map', to: 'road_maps#create'
		post 'v1/program/startup/show-road-maps', to: 'road_maps#show_all'
		put 'v1/program/startup/edit-road-map-startup', to: 'road_maps#startup_edit'
		put 'v1/program/startup/edit-road-map-admin', to: 'road_maps#admin_edit'
		###########road map#############

		######Resource Api's###########
		post 'v1/program/startup/request-resource', to: 'resources#create'
		###############################


		########Frameworks#########
		post 'v1/program/create-framework' ,to: 'frameworks#create'
		get 'v1/program/show-all-framworks', to: 'frameworks#show_all'
		post 'v1/program/show-framework', to: 'frameworks#show' 
		put 'v1/program/edit-framework', to: 'frameworks#edit' 
		put 'v1/program/delete-framework', to: 'frameworks#delete' 
		###########################

		##########Activities###########################
		post 'v1/program/framework/create-activity' , to: 'activities#create'
		get 'v1/program/framework/show-all-activities', to: 'activities#show_all'
		post 'v1/program/framework/show-activity', to: 'activities#show' 
		put 'v1/program/framework/edit-activity', to: 'activities#edit' 
		put 'v1/program/framework/delete-activity', to: 'activities#delete' 
		##############################

		################checklists###########################
		post 'v1/program/framework/activity/create-checklist' , to: 'checklists#create'
		get 'v1/program/framework/activity/show-all-checklists', to: 'checklists#show_all'
		post 'v1/program/framework/activity/show-checklist', to: 'checklists#show' 
		put 'v1/program/framework/activity/edit-checklist', to: 'checklists#edit' 
		put 'v1/program/framework/activity/delete-checklist', to: 'checklists#delete' 
		###################################

		######Activity response##############
		post 'v1/program/framework/activity/create-activity-response', to: 'activity_responses#create'
		put 'v1/program/framework/activity/rating-activity-response', to: 'activity_responses#rating_by_admin'
		post 'v1/program/framework/activity/show-activity-response', to: 'activity_responses#show_all'
		#####################################




	end

end
