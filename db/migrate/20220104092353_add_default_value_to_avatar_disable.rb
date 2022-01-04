class AddDefaultValueToAvatarDisable < ActiveRecord::Migration[6.1]
  def change
    change_column :articles, :avatar_disable, :boolean, default: false
  end
end
