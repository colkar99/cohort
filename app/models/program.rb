class Program < ApplicationRecord
  belongs_to :program_type
  belongs_to :ProgramLocation
  has_many :program_registration_questions
  has_many :startup_registration_questions
  has_many :startup_registrations
  has_many :startup_profiles ,through: :startup_registrations
  belongs_to :framework
end
