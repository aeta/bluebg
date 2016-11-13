class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
      @userposts = Post.of_current_user(current_user.id).order('created_at DESC').page params[:page]
    else
      @posts = Post.all.order('created_at DESC').page params[:page]
    end
  end

  def eye_exit
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def eye_open
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def browse
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created"
      redirect_to posts_path
    else
      flash.now[:error] = "Your post could not be created"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(update_params)
      flash[:success] = "Your post has been updated"
      redirect_to(post_path(@post))
    else
      flash.now[:error] = "Your post could not be updated"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:error] = "Your post has been deleted"
    redirect_to posts_path
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
      if @post.user != current_user
        create_notification @post
      end
    end
  end

  def unlike
    @post.unliked_by current_user
    if @post.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def owned_post
    if @post.user != current_user
      flash[:error] = "That post doesn't belong to you"
      redirect_to(post_path(@post))
    end
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def update_params
    params.require(:post).permit(:caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def create_notification(post)
    Notification.create(user_id: post.user.id, notified_by_id: current_user.id, post_id: post.id, identifier: post.id, notice_type: 'liked')
  end
end
