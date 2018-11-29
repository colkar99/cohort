class CreateSelectedMentors < ActiveRecord::Migration[5.2]
  def change
    create_table :selected_mentors do |t|
      t.references :user
      t.references :startup_profile
      t.string :title
      t.boolean :isActive, default: true
      t.integer :created_by
      t.integer :deleted_by
      t.datetime :deleted_at
      t.boolean :isDelete , default: false

      t.timestamps
    end
  end
end
