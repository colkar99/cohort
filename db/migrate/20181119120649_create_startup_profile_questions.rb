class CreateStartupProfileQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :startup_profile_questions do |t|
      t.string :title
      t.text :question
      t.text :description
      t.boolean :isActive, :default => true
      t.boolean :isDelete,:default => false
      t.integer :deleted_by
      t.integer :created_by
      t.string :deleted_date
      t.text :placeholder
      t.references :program, foreign_key: true

      t.timestamps
    end
  end
end
