class Article < ApplicationRecord
  has_rich_text :content
  has_paper_trail on: [:update]
  validates :title, :description, :content, presence: true
end
