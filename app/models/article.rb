class Article < ApplicationRecord
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  acts_as_votable
  
  enum status: { created: 0, prepared: 1, accepted: 2, rejected: 3, published: 4, archived: 5}

  belongs_to :category
  belongs_to :moderator
  has_many :reviews, dependent: :destroy, class_name: 'ArticleReview'
  validates :title, :description, :content, presence: true

  scope :important, -> { where(important: true) }
  scope :published, -> { where(status: :published) }
  scope :latest_published, -> { where(status: :published) }
 
  def avatar_absent_or_disabled?
    avatar.url.nil? || avatar_disable?
  end
end
