class LinkOfProgramQuestion < ApplicationRecord
  belongs_to :program
  belongs_to :application_question
  belongs_to :program_location
end
