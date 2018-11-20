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

	end

end
