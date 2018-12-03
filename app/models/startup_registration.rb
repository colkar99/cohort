class StartupRegistration < ApplicationRecord
  belongs_to :program 
  # belongs_to :startup_profile
  belongs_to :program_status

end
