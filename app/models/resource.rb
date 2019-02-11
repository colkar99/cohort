class Resource < ApplicationRecord
  has_many :milestone_resource_links
  has_many :milestones, through: :milestone_resource_links
end
