class CreateChecklistResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :checklist_responses do |t|
      t.references :activity, foreign_key: true
      t.references :course, foreign_key: true
      t.references :program, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.text :admin_feedback
      t.boolean :admin_responsed,default: false
      t.text :mentor_feedback
      t.boolean :mentor_responsed,default: false
      t.boolean :is_passed,default: false

      t.timestamps
    end
  end
end
