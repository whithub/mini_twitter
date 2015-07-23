class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    user = User.find_or_create_by(
      uid:      auth_info.extra.raw_info.user_id,
      provider: auth_info.provider
    )

    user.update_attributes(
      name:               auth_info.extra.raw_info.name,
      screen_name:        auth_info.extra.raw_info.screen_name,
      location:           auth_info.extra.raw_info.location,
      profile_image_url:  auth_info.extra.raw_info.profile_image_url,
      profile_banner_url: auth_info.extra.raw_info.profile_banner_url,
      statuses_count:     auth_info.extra.raw_info.statuses_count,
      friends_count:      auth_info.extra.raw_info.friends_count,
      followers_count:    auth_info.extra.raw_info.followers_count,
      oauth_token:        auth_info.credentials.token,
      oauth_token_secret: auth_info.credentials.secret
    )

    user

  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_KEY_SECRET"]
      config.access_token = self.oauth_token
      config.access_token_secret = self.oauth_token_secret
    end
  end

  def resize_profile_pic
    twitter_client.user.profile_image_url.to_s.gsub("_normal", "_bigger")
  end

  def twitter_timeline
    twitter_client.user_timeline
  end

  def retweet_count
    twitter_client.retweets_of_me
  end

  def post_tweet(tweet)
    twitter_client.update(tweet)
  end

end
