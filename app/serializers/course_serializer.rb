class CourseSerializer < ActiveModel::Serializer
  attributes :id ,:title,:description,:additional_description,:pass_metric,:target_date,:is_assigned,:created_by
  has_many :activities
  has_many :checklists

  
end

