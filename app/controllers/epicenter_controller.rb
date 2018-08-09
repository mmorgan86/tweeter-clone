class EpicenterController < ApplicationController

  before_action :authenticate_user!

  def feed
    @following_tweets = []

    Tweet.order(created_at: :desc).each do |tweet|
      if tweet.user_id === current_user.id || current_user.following.include?(tweet.user_id)
        @following_tweets.push(tweet)
      end
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save
    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save
    redirect_to show_user_path(id: params[:id])
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def all_users
    @users = User.all 
  end

  def following
    # find users we are following
    @user = User.find(params[:id])
    @users = []

    User.all.each { |u| @users.push(u) if @user.following.include? u.id }
  end

  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each { |u| @users.push(u) if u.following.include? @user.id }
  end

end
