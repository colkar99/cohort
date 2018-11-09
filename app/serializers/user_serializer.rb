class UserSerializer < ActiveModel::Serializer
  attributes :id ,:first_name,:last_name,:access_token,:phone_number
end
