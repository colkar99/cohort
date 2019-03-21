class NewsFeedComment < ApplicationRecord
  belongs_to :news_feed
  belongs_to :startup_profile, optional: true

  after_create_commit {NewsFeedBroadcastJob.perform_later(self)}

end
