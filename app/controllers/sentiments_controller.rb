class SentimentsController < ApplicationController
  include TwitterApi
  include Sentiment
    
  def dashboard
  	handler = params[:handler]
  	@user_profile = TwitterApi.fetch_user(handler)
    
    if handler.blank?
      redirect_to :root, :flash => { :error => "Forgot to put the meat in the sandwich?  Please write a twitter handler in the box to crunch data." }
    elsif @user_profile && @user_profile[:error].present?
      flash.keep
      redirect_to :root, :flash => { :error => "Hey sorry, but we couldn't find a twitter handler with #{handler}. " }
    end
    
  end


  def get_tweets
    @sentiments = params[:sentiments]
  	handler = params[:handler]
    uid = params[:uid].presence || 0
    @user_profile = TwitterApi.fetch_user(handler)
  	@feeds = {all: [], 
      positive: {feeds: [] , total_percent: 0 }, 
      negative: {feeds: [] , total_percent: 0 }, 
      neutral: {feeds: [] , total_percent: 0 }
    }
    start = Time.zone.now
  	@tweets = TwitterApi.search_tweets(handler)
    last = Time.zone.now
    puts "**************** time taken = #{last-start}"
  	unless @tweets[0].blank? || @tweets[0][:error]
  		start = Time.zone.now
      @feeds = segregate(@tweets)
      last = Time.zone.now
      puts "**************** time taken sentiment = #{last-start}"
  	end
    
    @in_progress_tweets = get_selected_tweets(TweetStatus::IN_PROGRESS, uid)
    @closed_tweets = get_selected_tweets(TweetStatus::CLOSED, uid)
  end
  
  

  def comparison
    handler = params[:compared_to]
    @user_1 = params.permit(:profile_image_url, :name, :screen_name, :statuses_count, :friends_count, :followers_count, :description)
    @graph_data = []
    @graph_data << {"#{params[:screen_name]}": {positive: params[:positive], negative: params[:negative], neutral: params[:neutral]}.to_a}
    @user_2 = TwitterApi.fetch_user(handler||params[:screen_name])
    @tweets = TwitterApi.search_tweets(handler)
    unless @tweets[0].blank? || @tweets[0][:error]
      data = segregate(@tweets)
      @graph_data << {"#{handler}": {positive: data[:positive][:total_percent], negative: data[:negative][:total_percent], neutral: data[:neutral][:total_percent]}.to_a}
      p @graph_data
    else
      @graph_data << {"#{handler}": {positive: 0, negative: 0, neutral: 0}.to_a}
    end
  end
  
   
  
  def get_selected_tweets(status, uid)
    
    @selected_tweets_mappings = SelectedTweet.joins(:user).joins(:tweet_statuses).where("users.uid" => uid, "tweet_statuses.status" => status)
                                              .select("selected_tweets.message", "users.id", "selected_tweets.tweet_id", "selected_tweets.posted_by", "tweet_statuses.status")
    feeds = {all: [], 
      positive: {feeds: [] , total_percent: 0 }, 
      negative: {feeds: [] , total_percent: 0 }, 
      neutral: {feeds: [] , total_percent: 0 }
    }
    @selected_tweets = []
    
    @selected_tweets_mappings.each do |selected_tweet_mapping|
      @selected_tweets <<  TwitterApi.fetch_tweet(selected_tweet_mapping.tweet_id).as_json
    end
    
    unless @selected_tweets[0].blank? || @selected_tweets[0][:error]
      feeds = segregate(@selected_tweets)
    end
    
    return feeds
    
  end
  

  def static_dashboard

  end

end
