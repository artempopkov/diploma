class Article < ApplicationRecord
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  belongs_to :category
  validates :title, :description, :content, presence: true

  def avatar_absent_or_disabled?
    avatar.url.nil? || avatar_disable?
  end
end
