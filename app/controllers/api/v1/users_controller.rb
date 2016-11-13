class Api::V1::UsersController < Api::V1::BaseController


  def show
    user = User.find(params[:id])

    render(json: Api::V1::UserSerializer.new(user).to_json)
  end
  include ActiveHashRelation
  def index
    users = User.all

    users = apply_filters(users, params)

    render ActiveModel::ArraySerializer.new(users, each_serializer: Api::V1::UserSerializer, root: 'users',)
  end
end
