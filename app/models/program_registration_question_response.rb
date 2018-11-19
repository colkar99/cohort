class ProgramRegQuesResponse < ApplicationRecord
  belongs_to :program_reg_question
  belongs_to :startup_profile
  belongs_to :program_location
end
