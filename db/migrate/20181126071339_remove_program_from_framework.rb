class RemoveProgramFromFramework < ActiveRecord::Migration[5.2]
  def change
    remove_column :frameworks, :program, :reference
  end
end
