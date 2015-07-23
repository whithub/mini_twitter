class TweetsController < ApplicationController

  def create
    if current_user.twitter_client.update(params[:text])
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def update
    current_user.update(params[:text])
    redirect_to dashboard_path
  end

end





