class RemoveActivityFromChecklist < ActiveRecord::Migration[5.2]
  def change
    remove_reference :checklists, :activity, foreign_key: true
  end
end
