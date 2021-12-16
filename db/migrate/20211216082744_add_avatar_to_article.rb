class AddAvatarToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :avatar, :string
  end
end
