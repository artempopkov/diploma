class ArticleReview < ApplicationRecord
  include TranslateEnum
  belongs_to :article
  belongs_to :moderator
  has_rich_text :comment
  enum status: { accepted: 0, rejected: 1 }
  translate_enum :status
end
