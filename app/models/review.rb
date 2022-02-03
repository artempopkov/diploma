class Review < ApplicationRecord
  belongs_to :article
  has_rich_text :comment
end
