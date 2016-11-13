class Post < ActiveRecord::Base
  acts_as_votable
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :caption
  validates :user_id, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :image, presence: true
  has_attached_file :image,
  convert_options: {
    :all => "-grayscale Rec709Luminance -fill 'blue' -tint 60"
  },
  styles: {
            :medium => "640x"
          }
  validates_attachment_content_type :image, :content_type =>
 /\Aimage\/.*\Z/
  scope :of_followed_users, -> (following_users) { where user_id: following_users }
  scope :of_current_user, -> (following_users) { where user_id: following_users }

end
