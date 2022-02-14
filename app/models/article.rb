class Article < ApplicationRecord
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  acts_as_votable
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => :session_hash

  enum status: { inactive: 0, active: 1, published: 2, archived: 3 }

  belongs_to :category
  belongs_to :moderator

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :impressions, class_name: 'Impression', foreign_key: 'impressionable_id', dependent: :destroy
  has_many :impressions, as: :impressionable, dependent: :destroy

  validates :title, :description, :content, presence: true

  scope :important, -> { where(important: true) }
  scope :published, -> { where(status: :published) }
  scope :latest_published, -> { where(status: :published).order(created_at: :desc) }
  scope :trending, -> { where(status: :published).order(impressions_count: :desc) }
  
  def current_review
    reviews.last
  end

  def need_fixes?
    true if reviews.count.positive? && updated_at < reviews.last.created_at + 3.seconds
  end

  def not_published?
    true unless published?
  end
end
