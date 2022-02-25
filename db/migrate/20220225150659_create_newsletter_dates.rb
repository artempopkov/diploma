class CreateNewsletterDates < ActiveRecord::Migration[6.1]
  def change
    create_table :newsletter_dates do |t|
      t.timestamp :sent_at, null: false
      t.integer :schedule, null: false, default: 0
      t.timestamps
    end
  end
end
