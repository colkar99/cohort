class RemoveTypeToUserRole < ActiveRecord::Migration[5.2]
  def change
  	    remove_column :user_roles, :type, :string

  end
end
