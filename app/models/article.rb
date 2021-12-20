class Article < ApplicationRecord
  has_rich_text :content
  has_paper_trail on: [:update]
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :tags
  enum status: { inactive: 0, active: 1, published: 2, archived: 3 }
  belongs_to :category
  validates :title, :description, :content, presence: true

  def updated?
    Version.where(item_id: id, event: :update).empty? ? false : true
  end
end
