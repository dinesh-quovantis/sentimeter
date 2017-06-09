class WorkLog < ApplicationRecord
	belongs_to :selected_tweet

	validates_presence_of :comment
end
