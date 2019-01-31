class Framework < ApplicationRecord
	# has_many :framework_activity_links
	# has_many :activities, through: :framework_activity_links , dependent: :destroy
	# has_many :checklists , dependent: :destroy
	has_many :activity_responses
	has_many :programs
	has_many :framework_course_links
	has_many :courses , through: :framework_course_links , dependent: :destroy
    # has_many :activities ,through: :activity_responses
end
