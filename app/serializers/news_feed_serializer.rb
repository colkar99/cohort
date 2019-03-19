class NewsFeedSerializer < ActiveModel::Serializer
  attributes :id ,:title,:images,:description,:created_at,:updated_at
  has_many :news_feed_comments
  belongs_to :program
end

