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
	end

end
