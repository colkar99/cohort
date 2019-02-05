class RoadMap < ApplicationRecord
  belongs_to :program
  belongs_to :startup_profile
  has_many :resources
  has_many :milestones
end



