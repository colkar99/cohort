class NewsFeedCommentSerializer < ActiveModel::Serializer
  attributes :id ,:comment,:created_at,:updated_at,:startup_profile
  belongs_to :news_feed
  def startup_profile
  	object.startup_profile
  end
end

