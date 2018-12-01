class AddIsActiveAndIsDeleteAndCreatedByAndDeletedByAndDeletedAtToRole < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :isActive, :boolean, default: true
    add_column :roles, :isDelete, :boolean, default: false
    add_column :roles, :created_by, :integer
    add_column :roles, :deleted_by, :integer
    add_column :roles, :deleted_at, :datetime
  end
end
