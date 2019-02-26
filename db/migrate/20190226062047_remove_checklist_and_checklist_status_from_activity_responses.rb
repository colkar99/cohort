class RemoveChecklistAndChecklistStatusFromActivityResponses < ActiveRecord::Migration[5.2]
  def change
    remove_reference :activity_responses, :checklist, foreign_key: true
    remove_column :activity_responses, :checklist_status, :boolean
  end
end
