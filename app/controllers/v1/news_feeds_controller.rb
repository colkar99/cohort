module V1
	 class NewsFeedsController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		

	 	def create_news_feed
			# module_grand_access = permission_control("news_feed","create")
			module_grand_access = true
			if module_grand_access
				news_feed = NewsFeed.new(news_feed_params)
				if news_feed.save!
					program = Program.find(news_feed.program_id)
	 				news_feeds = program.news_feeds
	 				# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)
					render json: news_feed,status: :created
				else
					render json: news_feed.errors,status: :bad_request
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized				
			end
	 	end

	 	def update_news_feed
			# module_grand_access = permission_control("news_feed","update")
			module_grand_access = true
			if module_grand_access
				news_feed = NewsFeed.find(params[:news_feed][:id])
				if news_feed.update!(news_feed_params)
					program = Program.find(news_feed.program_id)
	 				news_feeds = program.news_feeds
	 				# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)					
					render json: news_feed, status: :ok
				else
					render json: news_feed.errors, status: :bad_request
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized								
			end	 		
	 	end

	 	def delete_news_feed
			# module_grand_access = permission_control("news_feed","delete")
			module_grand_access = true
			if module_grand_access
				news_feed = NewsFeed.find(params[:news_feed][:id])
				news_feed_comments = news_feed.news_feed_comments
				if news_feed_comments.present?
					if news_feed_comments.destroy_all
						if news_feed.destroy
			 				# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)
			 				# NewsFeedBroadcastJob.perform_later(news_feed)					
							render json: news_feed, status: :ok
						else
							render json: news_feed.errors, status: :bad_request
						end
					else
						render json: {error: "something happened please contact site admin"},status: :ok
					end
				else
					if news_feed.destroy

		 				# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)
		 				# NewsFeedBroadcastJob.perform_later(news_feed)					
						render json: news_feed, status: :ok
					else
						render json: news_feed.errors, status: :bad_request
					end					
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized								
			end	 	 		
	 	end

	 	def show_program_related_news_feed
			# module_grand_access = permission_control("news_feed","show")
			module_grand_access = true
			if module_grand_access
				program = Program.find(params[:program][:id])
				if program.present?
					news_feeds = program.news_feeds.order(id: :desc)
					render json: news_feeds, status: :ok
				else
					render json: {error: "Program not found with this ID"},status: :bad_request
				end
			else
   			render json: { error: "You dont have permission to perform this action,Please contact Site admin" }, status: :unauthorized								
			end		 		
	 	end

	 	def create_comment_for_feed
	 		news_feed_comment = NewsFeedComment.new(news_feed_comment_params)
	 		if news_feed_comment.save!
	 			program = Program.find(news_feed_comment.news_feed.program_id)
	 			news_feeds = program.news_feeds
	 			# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)
	 			render json: news_feed_comment,status: :ok
	 		else
	 			render json: news_feed_comment.errors,status: :bad_request
	 		end
	 	end

	 	def update_comment_for_feed
	 		news_feed_comment = NewsFeedComment.find(params[:news_feed_comment][:id])
	 		if news_feed_comment.update!(news_feed_comment_params)
	 			program = Program.find(news_feed_comment.news_feed.program_id)
	 			news_feeds = program.news_feeds
	 			# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)
	 			render json: news_feed_comment,status: :ok
	 		else
	 			render json: news_feed_comment.errors,status: :bad_request
	 		end	 		
	 	end

	 	def delete_comment_for_feed
	 		news_feed_comment = NewsFeedComment.find(params[:news_feed_comment][:id])
	 		if news_feed_comment.destroy
	 			program = Program.find(news_feed_comment.news_feed.program_id)
	 			news_feeds = program.news_feeds
	 			# Pusher.trigger('events-channel', 'news-feed-data', {:news_feeds => news_feeds}.as_json)
	 			render json: news_feed_comment,status: :ok
	 		else
	 			render json: news_feed_comment.errors,status: :bad_request
	 		end	 		
	 	end
	 	def show_comment_for_feed
	 		news_feed = NewsFeed.find(params[:news_feed][:id]) 
			if news_feed.present?
				news_feed_comments = news_feed.news_feed_comments 
				render json: news_feed_comments,status: :ok
			else
				render json: {error: "News feed not found with this ID"},status: :bad_request
			end		
	 	end

	 	# def trigger_pusher_event
	 	# 	program = params[:program][:id]
	 	# 	news_feeds = program.news_feeds
	 	# 	Pusher.trigger('events-channel', 'new-like', {:news_feeds => news_feeds}.as_json)

	 	# end

 	    private
 	    def news_feed_params
		    params.require(:news_feed).permit(:id,
		    									:title,
		    									:description,
		    									:images,
		    									:program_id,
		    									:startup_profile_id
		    									 )
 	    end
 	    def news_feed_comment_params
 	    	params.require(:news_feed_comment).permit(:id,:comment,:news_feed_id,:startup_profile_id)
 	    end

	 end
end


######activity params########

# t.string "name"
#     t.text "description"
#     t.text "placeholder"
#     t.integer "order"
#     t.integer "framework_id"
#     t.integer "created_by"
#     t.boolean "isActive", default: true
#     t.boolean "isDelete", default: false
#     t.integer "deleted_by"
#     t.datetime "deleted_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["framework_id"], name: "index_activities_on_framework_id"
	