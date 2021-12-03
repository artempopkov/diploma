class AddNameToModerator < ActiveRecord::Migration[6.1]
  def change
    add_column :moderators, :name, :string
  end
end
