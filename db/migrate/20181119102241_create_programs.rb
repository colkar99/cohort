class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|
      t.references :program_type, foreign_key: true
      t.string :title
      t.text :description
      t.string :start_date
      t.string :end_date
      t.integer :program_admin_id
      t.integer :seat_size
      t.references :location, foreign_key: true
      t.string :industry
      t.string :main_image
      t.string :logo_image
      t.string :duration
      t.string :application_start_date
      t.string :application_end_date
      t.integer :created_by
      t.boolean :isDelete,:default => false
      t.integer :deleted_by
      t.string :deleted_date

      t.timestamps
    end
  end
end
