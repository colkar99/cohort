class CreateStartupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :startup_users do |t|
      t.references :user, foreign_key: true
      t.references :startup_profile, foreign_key: true

      t.timestamps
    end
  end
end
