class DropTweetDetailFromSelectedTweets < ActiveRecord::Migration[5.0]
  def change
  	remove_column :selected_tweets, :tweet_details
  	add_column :selected_tweets, :posted_by, :string
  end
end
