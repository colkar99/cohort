class RoadMapSerializer < ActiveModel::Serializer
  attributes :id ,:goal,:strategy,:description,:from_date,:to_date,:reviewed_by,:reviewer_feedback,:program_id,:road_map_completed
  has_many :milestones
  has_many :resources
  
end

