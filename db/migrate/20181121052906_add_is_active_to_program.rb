class AddIsActiveToProgram < ActiveRecord::Migration[5.2]
  def change
    add_column :programs, :isActive, :boolean,:default => false
  end
end
