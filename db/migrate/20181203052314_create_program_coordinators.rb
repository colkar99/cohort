class CreateProgramCoordinators < ActiveRecord::Migration[5.2]
  def change
    create_table :program_coordinators do |t|
      t.references :user, foreign_key: true
      t.references :program, foreign_key: true
      t.references :role, foreign_key: true
      t.references :user_role, foreign_key: true

      t.timestamps
    end
  end
end
