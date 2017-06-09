class SelectedTweet < ApplicationRecord
	has_many :tweet_statuses, :dependent => :destroy
	has_many :work_logs, :dependent => :destroy
	belongs_to :user

	MAX_STATUS_LENGTH = 2

	validate :number_of_tweets
	validates_presence_of  :posted_by
	validates_presence_of  :tweet_id

	after_create :create_intial_tweet_status

	def current_status 
		tweet_statuses.order(:created_at).last.try(:status)
	end	

	private 

	def number_of_tweets
		error.add(:tweet_statuses, "too many") if tweet_statuses.length > MAX_STATUS_LENGTH
	end	

	def create_intial_tweet_status
		tweet_statuses.create(:status => IN_PROGRESS)
	end	
end
