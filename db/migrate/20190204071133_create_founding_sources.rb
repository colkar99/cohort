class CreateFoundingSources < ActiveRecord::Migration[5.2]
  def change
    create_table :founding_sources do |t|
      t.text :source
      t.text :amount
      t.text :description
      t.datetime :date
      t.references :startup_profile, foreign_key: true

      t.timestamps
    end
  end
end
