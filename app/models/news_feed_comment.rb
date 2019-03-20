class NewsFeedComment < ApplicationRecord
  belongs_to :news_feed
  belongs_to :startup_profile, optional: true
end
