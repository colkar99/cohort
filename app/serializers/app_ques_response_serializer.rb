class AppQuesResponseSerializer < ActiveModel::Serializer
  attributes :id,:application_question_id,:response,:reviewer_rating,
  			:reviewer_feedback,:program_location_id,:startup_registration_id,
  			:startup_response,:admin_response,:reviewed_by,:application_question
  def roles
  	object.application_question
  end
end

