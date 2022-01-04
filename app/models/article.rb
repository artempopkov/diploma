class Article < ApplicationRecord
  has_rich_text :content
  mount_uploader :avatar, AvatarUploader
  validates :title, :description, :content, presence: true
end
