class ProgramLocation < ApplicationRecord
	has_many :link_of_program_questions
 	has_many :application_questions , through: :link_of_program_questions
	has_many :startup_profile_questions
end
