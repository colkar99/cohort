Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	scope module: :v1 do
		post 'v1/authenticate', to: 'authentication#authenticate'
		post 'v1/user/registration', to: 'users#create'
		post 'v1/user/direct/registration', to: 'users#direct_registration'
		post 'v1/delete-user', to: 'users#delete'
		get 'v1/user-roles', to: 'user_roles#index'
		post 'v1/create-user-role', to: 'user_roles#create'
		post 'v1/edit-user-role', to: 'user_roles#edit'
		post 'v1/delete-user-role', to: 'user_roles#delete'
		post 'v1/create-program-type', to: 'program_types#create'
		put 'v1/edit-program-type', to: 'program_types#edit'
		get 'v1/show-program-types', to: 'program_types#show'
		post 'v1/delete-program-type', to: 'program_types#delete'

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
		post 'v1/create-program-registration-question', to: 'program_registration_questions#create'
		put 'v1/edit-program-registration-question', to: 'program_registration_questions#edit'
		get 'v1/show-program-registration-questions', to: 'program_registration_questions#show'
		post 'v1/delete-program-registration-question', to: 'program_registration_questions#delete'
		###############
		####startup Registration Questions######
		post 'v1/create-startup-profile-question', to: 'startup_profile_questions#create'
		put 'v1/edit-startup-profile-question', to: 'startup_profile_questions#edit'
		get 'v1/show-startup-profile-questions', to: 'startup_profile_questions#show'
		post 'v1/delete-startup-profile-question', to: 'startup_profile_questions#delete'
		###############

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

		################program status########
		post 'v1/program/registration', to: 'startup_registrations#create'
		get 'v1/show-statuses', to: 'program_statuses#show'
		put 'v1/edit-status', to: 'program_statuses#edit'
		post 'v1/delete-status', to: 'program_statuses#delete'
		######################################

	end

end
