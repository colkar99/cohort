class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.text :title
      t.text :description
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.text :where
      t.references :program
      t.boolean :isActive,default: :true
      t.integer :created_by

      t.timestamps
    end
  end
end
