class AddDefaultValueToImportant < ActiveRecord::Migration[6.1]
  def change
    change_column :articles, :important, :boolean, nil: false, default: false
  end
end
