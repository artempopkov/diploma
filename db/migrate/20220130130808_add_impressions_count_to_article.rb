class AddImpressionsCountToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :impressions_count, :int, :default => 0
  end
end
