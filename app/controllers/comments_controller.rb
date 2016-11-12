class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments.order("created_at ASC")

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
      if @post.user != current_user
        create_notification @post, @comment
      end
    else
      flash[:error] = "Your comment could not be posted. Something went wrong"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user || @post.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:context)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def create_notification(post, comment)
    Notification.create(user_id: post.user.id, notified_by_id: current_user.id, post_id: post.id, identifier: comment.id, notice_type: 'commented on')
  end
end
