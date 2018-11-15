class AddIsDeleteAndDeletedByAndCreatedByDeletedDateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isDelete, :boolean,:default => false
    add_column :users, :deleted_by, :integer
    add_column :users, :deleted_date, :timestamp
    add_column :users, :created_by, :integer
  end
end
