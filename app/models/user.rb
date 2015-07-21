class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    if user = find_by(uid: auth_info.extra.raw_info.user_id)
      user
    else
      create({name: auth_info.extra.raw_info.name,
              screen_name: auth_info.extra.raw_info.screen_name,
              location: auth_info.extra.raw_info.location,
              statuses_count: auth_info.extra.raw_info.statuses_count,
              friends_count: auth_info.extra.raw_info.friends_count,
              followers_count: auth_info.extra.raw_info.followers_count,
              uid: auth_info.extra.raw_info.user_id,
              provider: auth_info.provider,
              oauth_token: auth_info.credentials.token,
              oauth_token_secret: auth_info.credentials.secret,
        })
    end
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_key"]
      config.consumer_secret = ENV["twitter_secret"]
      config.access_token = self.oauth_token
      config.access_token_secret = self.oauth_token_secret
    end
  end

  def twitter_name
    twitter_client.name
  end

  def twitter_screen_name
    twitter_client.screen_name
  end
end
