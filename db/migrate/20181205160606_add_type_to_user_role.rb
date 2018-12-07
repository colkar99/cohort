class AddTypeToUserRole < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :type, :string
  end
end
