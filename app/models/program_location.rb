class ProgramLocation < ApplicationRecord
	has_many :application_questions
	has_many :startup_profile_questions
end
