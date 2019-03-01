class ChecklistSerializer < ActiveModel::Serializer
  attributes :id ,:name,:description,:course_id,:admin_responsed,:admin_feedback,:mentor_feedback,:mentor_responsed,:is_passed
 

  
end
