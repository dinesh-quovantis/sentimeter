# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, TwitterConfig["consumer_key"], TwitterConfig["consumer_secret"]
# end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["consumer_key"], ENV["consumer_secret"],
    {
      :secure_image_url => 'true',
      :image_size => 'original'
    }
end