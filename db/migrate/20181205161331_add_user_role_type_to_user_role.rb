class AddUserRoleTypeToUserRole < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :user_role_type, :string
  end
end
