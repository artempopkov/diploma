class Article < ApplicationRecord
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  enum status: { inactive: 0, active: 1, published: 2, archived: 3 }
  belongs_to :category
  validates :title, :description, :content, presence: true
end
