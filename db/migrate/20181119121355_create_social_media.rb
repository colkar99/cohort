class CreateSocialMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :social_media do |t|
      t.string :name
      t.boolean :isActive , :default => true
      t.timestamps
    end
  end
end
