class CreateFrameworks < ActiveRecord::Migration[5.2]
  def change
    create_table :frameworks do |t|
      t.string :title
      t.text :description
      t.string :activity_name
      t.integer :level, default: 0
      t.string :main_image
      t.string :thumb_image
      t.string :url
      t.integer :created_by
      t.boolean :isActive, default: true
      t.boolean :isDelete, default: false
      t.integer :deleted_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
