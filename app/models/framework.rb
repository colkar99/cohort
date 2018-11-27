class Framework < ApplicationRecord
	has_many :activities
	has_many :checklists
	has_many :activity_responses
	belongs_to :program
    # has_many :activities ,through: :activity_responses
end
