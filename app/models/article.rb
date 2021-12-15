class Article < ApplicationRecord
  has_rich_text :content
  has_paper_trail on: [:update]
  validates :title, :description, :content, presence: true

  def updated?
    Version.where(item_id: id, event: :update).empty? ? false : true
  end
end
