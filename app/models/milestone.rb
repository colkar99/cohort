class Milestone < ApplicationRecord
  belongs_to :road_map
    has_many :milestone_resource_links
  has_many :resources , through: :milestone_resource_links
end
