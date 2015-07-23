class TweetsController < ApplicationController

  def create
    current_user.post_tweet(params[:text])
    redirect_to dashboard_path
  end

  def update
    current_user.update(params[:text])
    redirect_to dashboard_path
  end

  # def retweet
  #   current_user.retweet(params[:id])
  #   redirect_to dashboard_path
  # end
end





