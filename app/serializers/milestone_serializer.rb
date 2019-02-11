class MilestoneSerializer < ActiveModel::Serializer
  attributes :id ,:name,:description,:metric,:month,:created_at,:updated_at
	has_many :resources
end
