class User < ActiveRecord::Base
  acts_as_voter
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :user_name, presence: true, length: { minimum: 4, maximum: 15 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:user_name]

  has_attached_file :avatar,
  convert_options: {
    :all => "-grayscale Rec709Luminance -fill 'blue' -tint 60"
  },
  styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
end
