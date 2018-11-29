class CreateAvtivityResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :avtivity_responses do |t|
      t.text :startup_response
      t.references :framework, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.references :activity, foreign_key: true
      t.references :checklist, foreign_key: true
      t.boolean :checklist_status, default: false
      t.integer :admin_rating
      t.text :admin_feedback
      t.integer :mentor_rating
      t.text :mentor_feedback
      t.integer :created_by
      t.boolean :isActive, default: true
      t.boolean :isDelete, default: false
      t.integer :deleted_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
