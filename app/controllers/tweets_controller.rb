class TweetsController < ApplicationController
	include TwitterApi

	skip_before_action :verify_authenticity_token, :only => [:mark_closed, :comment, :start_progress]
  before_action :redirect_to_twitter_log, :only => [:start_progress,:mark_resolved, :comment]		
  before_action :load_selected_tweet, :only => [:timeline, :mark_closed, :comment, :view_progress]
  
  def index

  end

  def timeline
  	set_selected_tweets
  	render :partial => 'timeline'
  end

  def view_progress
    set_selected_tweets
  end
  
  def start_progress
  	@request_selected_tweet = current_user.selected_tweets.create(selected_tweet_params)
  	@tweet_id = @request_selected_tweet.tweet_id
  	set_selected_tweets
  end

  def mark_closed
  	if current_user.present?
  		selected_tweet = current_user.selected_tweets.where(:tweet_id => @tweet_id).first
  		selected_tweet.tweet_statuses.create(:status => CLOSED)
  	end
  	set_selected_tweets
  end

  def comment
  	if params.keys.include?("reply_and_comment")
  		tweet_text = @request_selected_tweet.posted_by + " " + params[:comment_text].to_s 
  		@request_selected_tweet.work_logs.create(:comment => params[:comment_text], :has_been_tweeted => true)
  		TwitterApi.reply_tweet(tweet_text, @tweet_id)
  	elsif params.keys.include?("comment_only")
  		@request_selected_tweet.work_logs.create(:comment => params[:comment_text], :has_been_tweeted => false)		
  	end	
  	set_selected_tweets
  end

  private

  def set_selected_tweets
    @user_profile_id = params[:user_profile_id]
  	if current_user.present? && @user_profile_id == current_user.uid.to_s
      @selected_tweets = current_user.selected_tweets.where(:tweet_id => @tweet_id)
  	else
  		Rails.logger.info "************* 2"
      @selected_tweets = SelectedTweet.where(:tweet_id => @tweet_id)
  	end	
  	@selected_tweets = @selected_tweets.includes(:tweet_statuses, :work_logs).order('work_logs.created_at DESC')
    Rails.logger.info "**************** @selected_tweets #{@selected_tweets.inspect}"
  end	

  def load_selected_tweet
		@request_selected_tweet = SelectedTweet.find_by_id(params[:id])  	
		@tweet_id = @request_selected_tweet.tweet_id
  end	

  def selected_tweet_params
  	params.permit(:tweet_id, :message, :posted_by, :image_url, :name, :tweet_at)
  end	
  
end
