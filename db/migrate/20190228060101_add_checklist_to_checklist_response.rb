class AddChecklistToChecklistResponse < ActiveRecord::Migration[5.2]
  def change
  	    add_reference :checklist_responses, :checklist, foreign_key: true
  end
end
