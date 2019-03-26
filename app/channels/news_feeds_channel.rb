class NewsFeedsChannel < ApplicationCable::Channel
	def subscribed
		stream_from "news_feeds_channel"
	end

	def unsubscribed
		      chat_request_chanel_token = "Disconnected............."

      message = "Client disconnected"  

      ActionCable.server.broadcast "chat_request_#{chat_request_chanel_token}_channel",
                                   disconnected: message
	end
end