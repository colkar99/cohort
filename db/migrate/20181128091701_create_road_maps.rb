class CreateRoadMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :road_maps do |t|
      t.string :goal
      t.text :strategy
      t.text :description
      t.datetime :from_date
      t.datetime :to_date
      t.integer :reviewed_by
      t.text :reviewer_feedback
      t.references :program, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.boolean :isActive, default: true
      t.boolean :isDelete, default: false
      t.integer :deleted_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
