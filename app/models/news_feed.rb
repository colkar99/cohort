class NewsFeed < ApplicationRecord
  belongs_to :program
  has_many :news_feed_comments
  mount_base64_uploader :images, PictureUploader

end
