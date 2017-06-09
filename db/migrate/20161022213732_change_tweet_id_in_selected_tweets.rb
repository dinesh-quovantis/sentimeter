class ChangeTweetIdInSelectedTweets < ActiveRecord::Migration[5.0]
  def change
  	change_column :selected_tweets, :tweet_id, :string
  end
end
