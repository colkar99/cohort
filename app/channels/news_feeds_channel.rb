class NewsFeedsChannel < ApplicationCable::Channel
	def subscribed
		stream_from "news_feeds_channel"
	end
end