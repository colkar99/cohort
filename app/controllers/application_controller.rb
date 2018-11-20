class ApplicationController < ActionController::API
	before_action :authenticate_request
	attr_reader :current_user
	# include GetModuleAccess

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
