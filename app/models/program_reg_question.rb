class ProgramRegQuestion < ApplicationRecord
	belongs_to :program
	belongs_to :program_location
end
