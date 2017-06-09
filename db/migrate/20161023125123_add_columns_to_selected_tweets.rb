class AddColumnsToSelectedTweets < ActiveRecord::Migration[5.0]
  def change
  	add_column :selected_tweets, :image_url, :string
  	add_column :selected_tweets, :name, :string
  	add_column :selected_tweets, :tweet_at, :datetime
  end
end
