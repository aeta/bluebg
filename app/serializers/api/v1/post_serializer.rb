class Api::V1::PostSerializer < Api::V1::BaseSerializer
  attributes :id, :caption, :created_at, :updated_at, :image

  has_many :votes_for
  has_many :comments

  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
end
