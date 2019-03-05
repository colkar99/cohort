class MilestoneSerializer < ActiveModel::Serializer
  attributes :id ,:name,:description,:metric,:month,:created_at,:updated_at,:resources

	def resources
		  	object.resources
	end
end
