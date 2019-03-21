class NewsFeedBroadcastJob < ApplicationJob
	queue_as :default

	def perform(news_feed)
		ActionCable.server.broadcast "news_feeds_channel", news_feed: news_feed
	end
end