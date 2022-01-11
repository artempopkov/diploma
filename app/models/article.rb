class Article < ApplicationRecord
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  enum status: { inactive: 0, active: 1, published: 2, archived: 3 }
  belongs_to :category
  belongs_to :moderator
  has_many :reviews, dependent: :destroy
  validates :title, :description, :content, presence: true

  def current_review
    self.reviews.second_to_last
  end

  def changed_after_review?
    self.updated_at > self.reviews.second_to_last.created_at + 3.seconds
  end
end
