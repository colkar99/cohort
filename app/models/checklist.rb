class Checklist < ApplicationRecord
  belongs_to :framework
  belongs_to :activity
  has_many :activity_responses
end
