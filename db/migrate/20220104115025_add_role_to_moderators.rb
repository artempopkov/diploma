class AddRoleToModerators < ActiveRecord::Migration[6.1]
  def change
    add_column :moderators, :role, :integer, null: false, default: 0
  end
end
