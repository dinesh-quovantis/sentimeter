module Sentiment

  
  def analyze(text)
		score = @analyzer.score text
		sentiment = @analyzer.sentiment text
    sentiment
  end
  
  
  def segregate(feeds)
    total_count = feeds.size
    positive_feeds = []
    negative_feeds = []
    neutral_feeds = []
    all_feeds = []
    @analyzer = Sentimental.new
    @analyzer.load_defaults
		feeds.each do |feed|
      sentiment = analyze(feed["text"]).to_s
      feed = feed.merge!("sentiment": sentiment)
      all_feeds << feed
      positive_feeds << feed if sentiment == "positive"
      negative_feeds << feed if sentiment == "negative"
      neutral_feeds << feed if sentiment == "neutral"
		end
    return { all: all_feeds, 
      positive: sentiment_result(positive_feeds, total_count), 
      negative: sentiment_result(negative_feeds, total_count), 
      neutral: sentiment_result(neutral_feeds, total_count)
    }
    
  end
  
  
  def sentiment_result(sentiment_feeds, total_count)
    result = {}
    p "------------------#{sentiment_feeds.size}"
    if sentiment_feeds.present?
     result = {feeds: sentiment_feeds , total_percent: total_percent(sentiment_feeds.size, total_count) }
    else
     result = {feeds: [] , total_percent: 0 }
    end
   return result
   
  end
  
  
  def total_percent(sentiment_count, total_count)
    return ((sentiment_count.to_f * 100 )/total_count).round
  end
  
  
end