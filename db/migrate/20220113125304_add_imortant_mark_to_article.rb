class AddImortantMarkToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :important, :boolean
  end
end
