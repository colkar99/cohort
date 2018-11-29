class CreateProgramLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :program_locations do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state_province_region
      t.string :zip_pincode_postalcode
      t.string :country
      t.string :geo_location
      t.integer :created_by
      t.boolean :isDelete,:default => false
      t.string :deleted_by 
      t.string :delete_at

      t.timestamps
    end
  end
end
