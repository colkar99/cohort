class RemoveChecklistFromActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :checklist_id, :integer
  end
end
