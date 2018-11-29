class ChangeNewColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :mentor_users, :type, :type_name
  end
end
