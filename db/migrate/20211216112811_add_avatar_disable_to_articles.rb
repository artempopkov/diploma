class AddAvatarDisableToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :avatar_disable, :boolean
  end
end
