class AddCreatedByToStartupStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :program_statuses, :created_by, :string
    add_column :program_statuses, :isDelete, :boolean,:default => false
    add_column :program_statuses, :isActive, :boolean,:default => true
    add_column :program_statuses, :deleted_at, :datetime
    add_column :program_statuses, :deleted_by, :string
  end
end
