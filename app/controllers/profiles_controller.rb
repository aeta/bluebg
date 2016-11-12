class ProfilesController < ApplicationController
  before_action :finduser
  before_action :owned_profile, only: [:edit, :update]

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  def likes
    @posts = @user.votes.up.votables
  end

  def followers
    @followers = @user.followers
  end

  def following
    @following = @user.following
  end

  def comments
    @comments = @user.comments
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Your profile has been updated"
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.error.full_messages
      render :edit
    end
  end


  private

  def profile_params
    params.require(:user).permit(:avatar, :bio, :name, :location)
  end

  def finduser
    @user = User.find_by(user_name: params[:user_name])
  end

  def owned_profile
    if @user != current_user
      flash[:error] = "That is not your profile"
      redirect_to profile_path(@user.user_name)
    end
  end
end
