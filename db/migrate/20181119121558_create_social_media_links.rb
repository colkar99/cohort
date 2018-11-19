class CreateSocialMediaLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :social_media_links do |t|
      t.references :social_media, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.string :response

      t.timestamps
    end
  end
end
