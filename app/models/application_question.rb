class ApplicationQuestion < ApplicationRecord
	# belongs_to :program
	# belongs_to :program_location
	has_many :link_of_program_questions
    has_many :programs , through: :link_of_program_questions
    has_many :link_of_program_questions
    has_many :program_locations , through: :link_of_program_questions
    has_many :app_ques_responses
end
