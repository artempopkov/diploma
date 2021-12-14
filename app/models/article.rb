class Article < ApplicationRecord
  has_rich_text :content
  validates :title, :description, :content, presence: true
end
