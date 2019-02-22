class CreateSessionAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :session_attendees do |t|
      t.references :session, foreign_key: true
      t.references :user, foreign_key: true
      t.string :role
      t.boolean :attendence_confirmation, default: :false
      t.references :startup_profile, foreign_key: true
      t.boolean :isActive, default: :false
      t.integer :created_by

      t.timestamps
    end
  end
end
