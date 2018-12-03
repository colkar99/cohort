class ProgramCoordinator < ApplicationRecord
  belongs_to :user
  belongs_to :program
  belongs_to :role
  # belongs_to :user_role
end
