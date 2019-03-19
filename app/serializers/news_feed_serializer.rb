class NewsFeedSerializer < ActiveModel::Serializer
  attributes :id ,:title,:images,:description,:created_at,:updated_at,:posted_by
  has_many :news_feed_comments
  belongs_to :program
  def posted_by
  	object.startup_profile
  end
end

