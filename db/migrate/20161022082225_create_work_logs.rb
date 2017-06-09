class CreateWorkLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :work_logs do |t|
      t.text :comment
      t.integer :selected_tweet_id
      t.boolean :has_been_tweeted
      t.datetime :tweeted_at
      t.timestamps
    end
  end
end
