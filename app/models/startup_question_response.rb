class StartupQuestionResponse < ApplicationRecord
  belongs_to :startup_question
  belongs_to :startup_profile
  belongs_to :program
end
