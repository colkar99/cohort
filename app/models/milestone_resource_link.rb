class MilestoneResourceLink < ApplicationRecord
  belongs_to :milestone
  belongs_to :resource
  belongs_to :road_map
end
