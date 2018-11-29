class CreateStartupProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :startup_profiles do |t|
      t.string :startup_name
      t.string :password_digest
      t.string :email
      t.string :main_image
      t.string :thumb_image
      t.string :logo_image
      t.string :founded_date
      t.text :description
      t.boolean :incorporated
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
      t.integer :team_size
      t.string :current_stage

      t.timestamps
    end
  end
end
