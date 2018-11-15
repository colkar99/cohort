class AddIsDeleteAndCreatedByAndDeletedByToUserRole < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :isDelete, :boolean,:default => false
    add_column :user_roles, :created_by, :integer
    add_column :user_roles, :deleted_by, :integer
  end
end
