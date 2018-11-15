class AddIsDeleteAndDeletedByAndDeletedDateAndCreatedByToProgramType < ActiveRecord::Migration[5.2]
  def change
    add_column :program_types, :isDelete, :boolean
    add_column :program_types, :deleted_by, :integer
    add_column :program_types, :deleted_date, :string
    add_column :program_types, :created_by, :integer
  end
end
