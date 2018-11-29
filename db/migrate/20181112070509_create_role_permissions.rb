class CreateRolePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :role_permissions do |t|
      t.references :module_type, foreign_key: true
      t.references :role, foreign_key: true
      t.boolean :create_rule,:default => false
      t.boolean :edit_rule,:default => false
      t.boolean :update_rule,:default => false
      t.boolean :delete_rule,:default => false

      t.timestamps
    end
  end
end
