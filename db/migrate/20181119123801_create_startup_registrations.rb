class CreateStartupRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :startup_registrations do |t|
      t.string :startup_name
      t.string :founded_date
      t.string :website_url
      t.string :entity_type
      t.references :program, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.references :program_status, foreign_key: true

      t.timestamps
    end
  end
end
