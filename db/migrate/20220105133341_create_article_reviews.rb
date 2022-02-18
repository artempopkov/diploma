class CreateArticleReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :article_reviews do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
