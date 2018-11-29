class AddCreatedByToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :created_by, :string
    add_column :startup_registrations, :isDelete, :boolean,:default => false
    add_column :startup_registrations, :isActive, :boolean,:default => true
    add_column :startup_registrations, :deleted_at, :datetime
    add_column :startup_registrations, :deleted_by, :string

  end
end
