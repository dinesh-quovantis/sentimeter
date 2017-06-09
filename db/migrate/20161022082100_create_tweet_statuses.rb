class CreateTweetStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :tweet_statuses do |t|
      t.string :status
      t.integer :selected_tweet_id
      t.timestamps
    end
  end
end
