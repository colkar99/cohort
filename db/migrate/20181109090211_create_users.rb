class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firt_name
      t.string :last_name
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :access_token
      t.string :user_main_image
      t.string :credentials
      t.string :commitment

      t.timestamps
    end
  end
end
