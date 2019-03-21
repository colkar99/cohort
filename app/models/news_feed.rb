class NewsFeed < ApplicationRecord
  belongs_to :program
  belongs_to :startup_profile, optional: true
  has_many :news_feed_comments
  mount_base64_uploader :images, PictureUploader

  after_create_commit {NewsFeedBroadcastJob.perform_later(self)}

end
