class ProgramLocation < ApplicationRecord
	has_many :program_registration_questions
	has_many :startup_profile_questions
end
