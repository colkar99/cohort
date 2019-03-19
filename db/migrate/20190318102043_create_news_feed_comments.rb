class CreateNewsFeedComments < ActiveRecord::Migration[5.2]
  def change
    create_table :news_feed_comments do |t|
      t.text :comment
      t.references :news_feed, foreign_key: true
      t.references :startup_profile, foreign_key: true

      t.timestamps
    end
  end
end
