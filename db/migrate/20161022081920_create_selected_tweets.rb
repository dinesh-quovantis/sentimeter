class CreateSelectedTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :selected_tweets do |t|
      t.text :message
      t.integer :user_id
      t.integer :tweet_id
      t.text :tweet_details
      t.timestamps
    end
  end
end
