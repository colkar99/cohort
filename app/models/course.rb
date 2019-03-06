class Course < ApplicationRecord
	has_many :framework_course_links
	has_many :frameworks , through: :framework_course_links , dependent: :destroy
	has_many :course_activity_links
	has_many :activities, through: :course_activity_links , dependent: :destroy
	has_many :checklists
	attr_accessor :is_assigned,:target_date,:course_passed


end
