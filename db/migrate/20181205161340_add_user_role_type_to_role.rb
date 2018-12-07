class AddUserRoleTypeToRole < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :user_role_type, :string
  end
end
