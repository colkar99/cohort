class UserSerializer < ActiveModel::Serializer
  attributes :id ,:first_name,:last_name,:full_name,:email,:access_token,:phone_number,:user_type,:roles
  def roles
  	object.roles
  end
end
