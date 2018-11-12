class RolePermission < ApplicationRecord
  belongs_to :module_type
  belongs_to :role
end
