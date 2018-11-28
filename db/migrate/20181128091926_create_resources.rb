class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :resource_type
      t.string :no_of_resource
      t.string :hours_needed
      t.datetime :date_needed
      t.string :payment_mode
      t.references :road_map, foreign_key: true
      t.boolean :isActive, default: true
      t.boolean :isDelete, default: false
      t.integer :deleted_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
