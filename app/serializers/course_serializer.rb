class CourseSerializer < ActiveModel::Serializer
  attributes :id ,:title,:description,:additional_description,:created_by
  has_many :activities
  
end

