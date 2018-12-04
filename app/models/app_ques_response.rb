class AppQuesResponse < ApplicationRecord
  belongs_to :application_question
  # belongs_to :startup_profile
  belongs_to :program_location
  belongs_to :startup_registration
end
