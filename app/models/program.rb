class Program < ApplicationRecord
  mount_base64_uploader :main_image, PictureUploader
  mount_base64_uploader :logo_image, PictureUploader
  belongs_to :program_type
  belongs_to :ProgramLocation
  # has_many :application_questions
  has_many :startup_registration_questions
  has_many :startup_registrations
  has_many :startup_profiles ,through: :startup_registrations
  # belongs_to :framework
  has_many :activity_responses
  has_many :link_of_program_questions
  has_many :application_questions , through: :link_of_program_questions
  has_many :sessions
  has_many :news_feeds

  
end
