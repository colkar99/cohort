class AddTwitterUrlAndYoutubeUrlAndInstagramUrlAndPinterestUrlToStartupProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_profiles, :twitter_url, :string
    add_column :startup_profiles, :youtube_url, :string
    add_column :startup_profiles, :instagram_url, :string
    add_column :startup_profiles, :pinterest_url, :string
  end
end
