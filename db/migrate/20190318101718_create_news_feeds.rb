class CreateNewsFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :news_feeds do |t|
      t.string :title
      t.text :description
      t.string :images
      t.references :program, foreign_key: true

      t.timestamps
    end
  end
end
