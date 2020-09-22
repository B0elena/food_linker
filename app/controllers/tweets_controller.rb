class TweetsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def move_to_index
    unless (user_signed_in? || admin_signed_in?)
      redirect_to action: :index
    end
  end

  def tweet_params
    params.require(:tweet).permit(:tweet_name, :tweet_text, :image).merge(admin_id: current_admin.id)
  end
end
