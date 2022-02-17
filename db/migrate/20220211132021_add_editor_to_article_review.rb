class AddEditorToArticleReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :article_reviews, :moderator, foreign_key: true
  end
end
