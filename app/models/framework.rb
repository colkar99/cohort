class Framework < ApplicationRecord
	has_many :framework_activity_links
	has_many :activities, through: :framework_activity_links
	has_many :checklists
	has_many :activity_responses
	has_many :programs
    # has_many :activities ,through: :activity_responses
end
