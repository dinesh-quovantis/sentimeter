class TweetStatus < ApplicationRecord
	belongs_to :selected_tweet

	enum :status => {:in_progress => IN_PROGRESS, :closed => CLOSED}
end
