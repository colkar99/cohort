class RemoveProgramIdFromFramework < ActiveRecord::Migration[5.2]
  def change
    remove_column :frameworks, :program_id, :integer
  end
end
