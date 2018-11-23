class CreateChecklists < ActiveRecord::Migration[5.2]
  def change
    create_table :checklists do |t|
      t.string :name
      t.text :description
      t.references :framework, foreign_key: true
      t.references :activity, foreign_key: true
      t.integer :created_by
      t.boolean :isActive, default: true
      t.boolean :isDelete, default: false
      t.integer :deleted_by
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
