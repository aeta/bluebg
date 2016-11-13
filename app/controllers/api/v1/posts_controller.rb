class Api::V1::PostsController < Api::V1::BaseController
  def show
    post = Post.find(params[:id])

    render(json: Api::V1::PostSerializer.new(post).to_json)
  end

  def index
    posts = Post.all

    render (
    ActiveModel::ArraySerializer.new(
    posts,
    each_serializer: Api::V1::PostSerializer,
    root: 'posts',
    )
    )
  end
end
