class Impression < ApplicationRecord
  belongs_to :article, class_name: 'Article', foreign_key: 'article_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end