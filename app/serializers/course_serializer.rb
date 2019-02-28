class CourseSerializer < ActiveModel::Serializer
  attributes :id ,:title,:description,:additional_description,:is_assigned,:created_by
  has_many :activities
  has_many :checklists

  
end

