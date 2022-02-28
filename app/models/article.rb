class Article < ApplicationRecord
  include TranslateEnum
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  acts_as_votable
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => :session_hash

  enum status: { created: 0, prepared: 1, accepted: 2, rejected: 3, published: 4, archived: 5}
  translate_enum :status
  
  belongs_to :category
  belongs_to :moderator
  has_many :reviews, dependent: :destroy, class_name: 'ArticleReview'
  has_many :comments, dependent: :destroy
  has_many :impressions, as: :impressionable, dependent: :destroy

  validates :title, :description, :content, presence: true

  scope :important, -> { where(important: true) }
  scope :published, -> { where(status: :published) }
  scope :trending, -> { where(status: :published).order(impressions_count: :desc) }
  scope :latest_published, -> { where(status: :published) }
 
  def avatar_absent_or_disabled?
    avatar.url.nil? || avatar_disable?
  end

  def related_articles
    by_category = Article.published.where(category_id: category_id).where.not(id: id)
    by_category = Article.published.tagged_with(tag_list, any: true).where.not(id: id)
    (by_category + by_category).sample(3)
  end
end
