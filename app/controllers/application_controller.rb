class ApplicationController < ActionController::API
	before_action :authenticate_request
	attr_reader :current_user
	  include ActionController::MimeResponds

	# include GetModuleAccess

	def permission_control(module_name,action)
		@module = ModuleType.find_by_name(module_name)
		if @module
			@current_user = current_user
			if action == "create"
	    		@current_user.user_roles.each do |user_role|
	    			if @module.name == user_role.module_type.name
	    				return true if user_role.create_rule == true
	    			end
	    		end
	    	return false
	    	elsif action == "update"
	    		@current_user.user_roles.each do |user_role|
	    			if @module.name == user_role.module_type.name
	    				return true if user_role.update_rule == true
	    			end
	    		end
	    	return false
	    	elsif action == "show"
	    		@current_user.user_roles.each do |user_role|
	    			if @module.name == user_role.module_type.name
	    				return true if user_role.show_rule == true
	    			end
	    		end
	    	return false
	    	elsif action == "delete"
	    		@current_user.user_roles.each do |user_role|
	    			if @module.name == user_role.module_type.name
	    				return true if user_role.delete_rule == true
	    			end
	    		end
	    		return false
	    	end	
		else
			false  
		end




	end

	private

	def authenticate_request
	    @current_user = AuthorizeApiRequest.call(request.headers).result
	    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
	end

	def current_user
		auth_token = request.headers['HTTP_AUTHORIZATION']
		User.find_by_access_token(auth_token)
	end




	
	
end
