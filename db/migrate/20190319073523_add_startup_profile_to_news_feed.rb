class AddStartupProfileToNewsFeed < ActiveRecord::Migration[5.2]
  def change
    add_reference :news_feeds, :startup_profile, foreign_key: true
  end
end
