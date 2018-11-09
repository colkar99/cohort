class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	   rename_column :users, :firt_name, :first_name

  end
end
