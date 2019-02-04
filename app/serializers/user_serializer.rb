class UserSerializer < ActiveModel::Serializer
  attributes :id ,:first_name,:last_name,:full_name,:email,:access_token,:phone_number,:user_type,:roles,:is_first_time_logged_in
  def roles
  	object.roles
  end
end
