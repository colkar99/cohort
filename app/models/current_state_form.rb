class CurrentStateForm < ApplicationRecord
  # belongs_to :startup_profile
  belongs_to :program
  belongs_to :startup_registration
end
