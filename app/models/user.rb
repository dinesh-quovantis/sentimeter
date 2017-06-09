class User < ApplicationRecord

  has_many :selected_tweets

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.screen_name = auth.as_json["extra"]["access_token"]["params"]["screen_name"]
    end
  end
  
  
end
