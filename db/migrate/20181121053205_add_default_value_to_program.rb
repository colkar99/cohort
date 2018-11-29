class AddDefaultValueToProgram < ActiveRecord::Migration[5.2]
  def change
  	change_column :programs, :isActive, :boolean, default: true
  end
end
