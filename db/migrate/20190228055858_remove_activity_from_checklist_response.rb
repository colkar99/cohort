class RemoveActivityFromChecklistResponse < ActiveRecord::Migration[5.2]
  def change
    remove_reference :checklist_responses, :activity, foreign_key: true
  end
end
