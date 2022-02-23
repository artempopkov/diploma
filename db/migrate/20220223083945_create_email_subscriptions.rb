class CreateEmailSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :email_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint  :subscriptionable_ids, array: true, default: [], nil: true
      t.string  :subscriptionable_type
      t.timestamps
    end
  end
end
