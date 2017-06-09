module TwitterApi
		extend self
		# Authenticate Twitter REST API
		def client(consumer_key=ENV["consumer_key"],consumer_secret=ENV["consumer_secret"],access_token=ENV["access_token"],access_token_secret=ENV["access_token_secret"])
			@client = Twitter::REST::Client.new do |config|
			  config.consumer_key        = consumer_key
			  config.consumer_secret     = consumer_secret
			  config.access_token        = access_token
			  config.access_token_secret = access_token_secret
			end		
		end

		# Search tweets with a given hashtag
		def search_tweets(hashtag, param_values=nil)
			return []
			max_count= 200			
			hashtag = fetch_hashtag(hashtag)		
			begin	
				data = client.search(hashtag,{exclude_replies: true,include_entities: false,result_type: 'recent', count: max_count})
				data.collect{|x|x.as_json(:only=>[:created_at,:id,:text,:retweet_count,:favorite_count]).merge!({"user": x.user.as_json(:only=>[:id,:name,:screen_name,:location,:profile_image_url,:followers_count])})}.take(max_count)
			rescue Twitter::Error => e
				[{error: e.as_json}]
			end
		end

		# Fetch a particular tweet with ID
		def fetch_tweet(tweet_id)
			begin	
				data = client.status(tweet_id)
				data.as_json(:only=>[:created_at,:id,:text,:retweet_count,:favorite_count]).merge!({"user": data["user"].as_json(:only=>[:id,:name,:screen_name,:location,:profile_image_url,:followers_count])})
        
			rescue Twitter::Error => e 
				{error: e.as_json}
			end
		end

	  # Tweet (as the authenticated user) 
		def tweet(text)
			begin
				client.update(text)
			rescue Twitter::Error => e
				{error: e.as_json}
			end
		end

		# Reply to Tweet (as the authenticated user) 
		def reply_tweet(text,in_reply_to_status_id=nil)
			begin
				client.update(text,{in_reply_to_status_id: in_reply_to_status_id})
			rescue Twitter::Error => e
				{error: e.as_json}
			end
		end

		# Follow a user (by screen name or user ID)) 
		def follow(screen_name)
			begin
				client.follow(screen_name)
			rescue Twitter::Error => e
				{error: e.as_json}
			end
		end

		# Fetch a user (by screen name or user ID)
		def fetch_user(screen_name)
			begin
				data = client.user(screen_name)
				data.as_json(:only=>[:id,:name,:screen_name,:location,:description,:followers_count,:friends_count,:statuses_count,:profile_image_url])
			rescue Twitter::Error => e
				{error: e.as_json}
			end
		end

		# Test for the existence of friendship between two users
		def is_follow?(source, target)
			begin
				client.friendship?(source, target)
			rescue Twitter::Error => e
				{error: e.as_json}
			end
		end

		private
			def fetch_hashtag(hashtag)
				hashtag[0].eql?("@") ? "#{hashtag} -RT" : "@#{hashtag} -RT"
			end

			def query_params(param_values)
				if param_values
					params = {
						:since => param_values[:since],
					  :until => param_values[:until]
					}
				else
					params = {
						:since => (DateTime.now-30.days).strftime("%Y-%m-%d"),
					  :until => (DateTime.now).strftime("%Y-%m-%d")
					}
				end
			end	
			
end


