class RemoveColumnResponserIdInCurrentStateForm < ActiveRecord::Migration[5.2]
  def change
  	remove_column :current_state_forms, :responser_id
  end
end
