module ApplicationCable
  class Channel < ActionCable::Channel::Base
  	# identified_by :current_user

  	def connect
  		self.current_user = find_verified_user
  		# logger.add_tags 'ActionCable' ,current_user.email
  		# logger.add_tags 'ActionCable' ,current_user.full_name
  	end
  	protected

  	def find_verified_user
  		if current_user.present?
  			current_user
  		end
  	end
  end
end
