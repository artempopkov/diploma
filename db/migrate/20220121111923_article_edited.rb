class ArticleEdited < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :edited, :boolean, default: false
  end
end
