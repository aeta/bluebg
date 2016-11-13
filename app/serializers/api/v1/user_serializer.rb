class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :verified, :created_at, :updated_at, :user_name

  has_many :posts
  has_many :following
  has_many :followers

  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
end
