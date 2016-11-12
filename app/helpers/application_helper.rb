module ApplicationHelper
  def alert_for(flash_type)
    { success: 'alert-success',
      error:  'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def form_image_select(post)
    return image_tag post.image.url(:medium),
    id: 'image-preview-1',
    class: 'img-responsive' if post.image.exists?
    image_tag 'placeholder.jpg', id: 'image-preview-1', class: 'img-responsive'
  end

  def user_like_count(user)
    if user.votes.up.count != 1
      return pluralize user.votes.up.count, 'likes'
    else
      return '1 like'
    end
  end

  def user_follower_count(user)
    if user.followers.count != 1
      return pluralize user.followers.count, 'followers'
    else
      return '1 follower'
    end
  end

  def user_following_count(user)
    if user.following.count != 1
      @followcount = pluralize user.following.count, ''
      return 'following ' + @followcount
    else
      return 'following 1'
    end
  end

  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
    id: 'image-preview-1',
    class: 'img-responsive img-circle profile-image' if user.avatar.exists?
    image_tag 'default-avatar.jpg', id: 'image-preview-1', class: 'img-responsive img-circle profile-image'
  end
end
